class Proxy < Record 

  def amount_in_cents=(amount_in_cents)
    write_attribute(:amount_in_cents, 0)
  end

end
