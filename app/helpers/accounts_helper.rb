module AccountsHelper
  def accounts_select_for(accounts=nil)
    accounts ||= Account.sub_accounts
    accounts.map{|a| [a.name, a.id] }
  end
  def account_link_for(a)
    link_to a.name, account_path(a)
  end
end
