require 'active_record/fixtures'

#Asset.create({:name => 'Bank Accounts'})

def seed_accounts(hash)
  hash.each_pair do |type, children|
    children.each{ |name| type.create(
      :name => name
    ) }
  end
end

seed_accounts({
  Asset      => ['Bank Accounts', 'Current Assets', 'Fixed Assets', 'Other Assets'],
  Liability  => ['Current Liabilities', 'Long Term Liabilities']
})



#
## Set up some basic accounts
#seed_accounts({
#  Asset      => ['Current Assets', 'Fixed Assets', 'Other Assets'],
#  Liabilities' => ['Current Liabilities', 'Long Term Liabilities'],
#  'Revenue'     => ['Sales', 'Other Miscellaneous Income'],
#  'Expenses'    => [
#                    'Bank Charges',
#                    'Dues and Subscriptions',
#                    'Insurance',
#                    'Legal and Professional Fees',
#                    'Meals and Entertainment',
#                    'Office Expenses',
#                    'Other Miscellaneous Expenses',
#                    'Rent or Lease',
#                    'Repair and Maintenance',
#                    'Supplies',
#                    'Taxes and Licenses',
#                    'Travel',
#                    'Utilities'
#                  ]})
#seed_accounts({
#  'Current Assets'      => ['Bank Accounts', 'Accounts Receivable'],
#  'Current Liabilities' => ['Credit Cards', 'Accounts Payable']
#})
