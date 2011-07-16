module AccountsHelper
  def accounts_select
    Account.find(:all).map{|a| [a.name, a.id] }
  end
  def account_link_for(a)
    link_to a.name, account_path(a)
  end
end
