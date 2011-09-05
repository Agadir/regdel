class AccountsController < InheritedResources::Base
  defaults :resource_class => Account, :collection_name => 'accounts', :instance_name => 'account'

  before_filter :clear_accounts_cache, :only => [:create, :update, :hide]
#  caches_action :index
  
  def create
    type = params[:account][:type]
    a = type.singularize.constantize.new(params[:account])
    if a.save
      redirect_to account_path(a)
    end
  end

  def hide
    if resource.hidden?
      flash[:notice] = 'This account is no longer hidden.'
      resource.show
    else
      flash[:notice] = 'This account is now hidden.'
      resource.hide
    end
    redirect_to resource_path(resource)
  end

  def show
    @account = Account.find(params[:id])
    @sub_accounts = Account.find_all_by_parent_id(params[:id])
    @entries = @account.entries.paginate(:page => params[:page], :per_page => 10)
  end

  def edit 
    @account = Account.find(params[:id])
  end

  private
    def clear_accounts_cache
      expire_action :action => :index
    end
end
