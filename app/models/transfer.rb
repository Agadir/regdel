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
end
