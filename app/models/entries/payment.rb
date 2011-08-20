class Payment < Entry


  def customer
    accounts.select{|a| a.is_a?(Customer)}.first
  end

  def required_account_types
    [BankAccount, Receivable, Customer]
  end
end
