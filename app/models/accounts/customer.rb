class Customer < Receivable 

  has_many :contacts
  has_many :invoices

end
