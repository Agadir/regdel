class Check < Entry


  def account_types_valid?
    my_entry_amounts = debits | credits
    errors.add(:entry_amounts, "accounts must include a bank account") unless my_entry_amounts.map(&:account).any?{|x| x.is_a?(BankAccount)}
  end
end
