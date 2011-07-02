class AccountsController < ApplicationController

  def index
    @accounts = Account.find(:all)
  end

  def show
  end

  def edit
  end

  def update

  end

  def new
    @account = Account.new
  end

  def create
    @account = params[:account][:type].constantize.new(params[:account])
    if @account.save
      redirect_to accounts_path
    end
  end
end
