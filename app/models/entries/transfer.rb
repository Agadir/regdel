class Transfer < Entry

  state_machine :initial => :open, :namespace => :transfer do

    event :close do
      transition :paid => :closed
    end

    state :open, :value => 400
    state :closed, :value => 430

  end

  def required_account_types
    [BankAccount, CreditCard]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a bank account or a credit card") unless account_types_valid?
  end
end
