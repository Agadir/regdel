class CreditCard < Liability
  ATTRIBUTES = [ [:acct_number, "Account Number" ], [:institution, "Institution" ] ]
  ACCOUNT_TYPES = [ ["Credit Card Account", "CreditCard"] ]

  has_one :external_account
  has_many :credit_card_charges


end
