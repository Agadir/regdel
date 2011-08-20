class Deposit < Entry
  belongs_to :bank_account

  def required_account_types
    [BankAccount]
  end

end
