require 'active_record/fixtures'

def seed_accounts(hash, parent_id=nil)
  hash.each_pair do |type, children|
    a = type.create(
      :name => type.name.titleize,
      :parent_id => parent_id
    )
    children.each do |name|
      if name.is_a?(String)
        type.create(
          :name => name,
          :parent_id => a.id
        )
      else
        seed_accounts(name, a.id)
      end
    end 
  end
end

seed_accounts({
  Asset      => ['Fixed Assets', 'Other Assets',
    {CurrentAsset => ['Accounts Receivable']},
    {BankAccount => ['Bank Account 1', 'Bank Account 2']}
  ],
  Liability  => ['Current Liabilities', 'Long Term Liabilities'],
  Expense => ['Electricity', 'Bank Fees', 'Insurance'],
  Revenue => [],
  Equity => [],
  Other => [ {Customer => ['Customer 1']} ]
})

Term.create(
  :terms => 'On receipt'
)
