class AccountsController < InheritedResources::Base
  defaults :resource_class => Account, :collection_name => 'accounts', :instance_name => 'account'

  before_filter :create_or_update, :only => [:edit, :new]

  def show
    @account = Account.find(params[:id])
    @sub_accounts = Account.find_all_by_parent_id(params[:id])
  end

  def create
    @account = params[:account][:type].constantize.new(params[:account])
    if @account.save
      redirect_to resource_path
    else
      render :new
    end
  end

private
  def create_or_update
    @method = params.has_key?(:id) ? 'PUT' : 'POST'
  end
end
