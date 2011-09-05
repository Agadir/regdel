class Customer < Company

  has_many :invoices
  has_many :payments

end
