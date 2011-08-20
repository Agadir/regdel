class Customer < Receivable 

  has_many :contacts
  has_many :invoices
  has_many :payments

end
