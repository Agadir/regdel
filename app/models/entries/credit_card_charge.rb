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

end
