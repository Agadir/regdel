class Invoice < Entry

  belongs_to :customer

  def required_account_types
    [Revenue, Customer]
  end

  def entry_account_types_validation
    errors.add(:entry_amounts, "accounts must have a revenue account or a customer account") unless account_types_valid?
  end

end
