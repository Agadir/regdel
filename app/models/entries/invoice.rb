class Invoice < Entry

  belongs_to  :term

  state_machine :initial => :open do
  end

  def customer
    accounts.select{|a| a.is_a?(Customer)}.first
  end

  def required_account_types
    [Revenue, Customer]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a revenue account or a customer account") unless account_types_valid?
  end

end
