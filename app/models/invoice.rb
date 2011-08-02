class Invoice < Entry

  def one_customer_account
    entry_amounts.map(&:account).any?{|x| x.is_a?(Customer)}
  end
end
