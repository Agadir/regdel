class Transfer < Entry

  def required_account_types
    [BankAccount, CreditCard]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a bank account or a credit card") unless account_types_valid?
  end
end
