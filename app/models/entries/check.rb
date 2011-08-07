class Check < Entry

  state_machine :initial => :open do
  end

  def required_account_types
    [BankAccount]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a bank account or a credit card") unless account_types_valid?
  end

end
