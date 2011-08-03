class Transfer < Entry

  def account_types_valid?
    my_entry_amounts = debits | credits
    errors.add(:entry_amounts, "accounts must have a bank account or a credit card") unless my_entry_amounts.map(&:account).any?{|x| x.is_a?(BankAccount) || x.is_a?(CreditCard)}
  end
end
