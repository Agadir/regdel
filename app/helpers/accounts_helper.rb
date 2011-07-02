module AccountsHelper
  def accounts_select
    Account.find(:all).map{|a| [a.name, a.id] }
  end
  def account_link_for(a)
    link_to a.name, account_path(a)
  end
  def new_sub_account_for(a)
    link_to "New Sub-Account", new_sub_account_path(@account)
  end
end
