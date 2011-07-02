class Account < ActiveRecord::Base
  ACCOUNT_TYPES = ["Asset", "Liability", "Equity", "Revenue", "Expense"]

  validates_uniqueness_of :name
  has_many :entries

  acts_as_nested_set

#  account_types[5] ="Gain"
#  account_types[6] ="Loss"
#  account_types[7] ="Distribution from Equity"
#  account_types[8] ="Contribution to Equity"
#  account_types[9] ="Comprehensive Income"
#  account_types[10] ="Other"
end
