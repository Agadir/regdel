class AccountsController < InheritedResources::Base
  defaults :resource_class => Account, :collection_name => 'accounts', :instance_name => 'account'

  before_filter :clear_accounts_cache, :only => [:create, :update]

  def create
    type = params[:account][:type]
    a = type.singularize.constantize.new(params[:account])
    if a.save
      redirect_to account_path(a)
    end
  end

  def show
    @account = Account.find(params[:id])
    @sub_accounts = Account.find_all_by_parent_id(params[:id])
  end

  def edit 
    @account = Account.find(params[:id])
  end

  private
    def clear_accounts_cache
      expire_fragment('accounts_table')
    end
end
