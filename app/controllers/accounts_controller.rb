class AccountsController < InheritedResources::Base
  defaults :resource_class => Account, :collection_name => 'accounts', :instance_name => 'account'

  def create
    type = params[:account][:type]
    a = type.constantize.new(params[:account])
    if a.save
      redirect_to accounts_path
    end
  end

  def show
    @account = Account.find(params[:id])
    @sub_accounts = Account.find_all_by_parent_id(params[:id])
  end

end
