class BankAccount < Asset
  ATTRIBUTES = [ [:acct_number, "Account Number" ], [:institution, "Institution" ] ]
  ACCOUNT_TYPES = [ ["Bank Account", "BankAccount"] ]

  has_one :external_account

  def method_missing(m, *args)
    if ATTRIBUTES.map{|x| x[0]}.include?(m)
      self.attrs
    else
      super
    end
  end
end
