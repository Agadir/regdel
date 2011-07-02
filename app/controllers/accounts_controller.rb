class AccountsController < ApplicationController

  before_filter :create_or_update, :only => [:edit, :new]

  def index
    @accounts = Account.find(:all)
  end

  def show
    @account = Account.find(params[:id])
    @sub_accounts = Account.find_all_by_parent_id(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      redirect_to accounts_path
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = params[:account][:type].constantize.new(params[:account])
    if @account.save
      redirect_to accounts_path
    else
      render :new
    end
  end

private
  def create_or_update
    @method = params.has_key?(:id) ? 'PUT' : 'POST'
  end
end
