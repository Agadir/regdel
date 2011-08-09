class Check < Entry

  state_machine :initial => :open, :namespace => :check do
    before_transition :from => :open, :to => :issued, :do => :post

    event :issue do
      transition :to => :issued
    end

    event :clear do
      transition :to => :cleared, :from => :issued
    end

    state :open, :value => 100
    state :issued, :value => 110
    state :cleared, :value => 120
  end

  def required_account_types
    [BankAccount, Expense, Vendor]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a bank account or a credit card") unless account_types_valid?
  end

end
