class Proxy < Record 
  # A proxy transaction is one that bridges two other transactions together
  # For example, when writing a check, the bank account balances with the 
  # payee, and the payee balances with the expense account

  def amount_in_cents=(amount_in_cents)
    write_attribute(:amount_in_cents, 0)
  end

end
