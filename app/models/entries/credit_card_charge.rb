class CreditCardCharge < Entry
  belongs_to :credit_card

  state_machine :initial => :open, :namespace => :credit_card do

    event :close do
      transition :paid => :closed
    end

    state :open, :value => 400
    state :closed, :value => 430

  end

  def required_account_types
    [CreditCard, Expense, Vendor]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a revenue account or a customer account") unless account_types_valid?
  end
end
