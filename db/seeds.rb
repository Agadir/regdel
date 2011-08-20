require 'active_record/fixtures'

def seed_accounts(hash, parent_id=nil)
  hash.each_pair do |type, children|
    a = type.create(
      :name => type.name.pluralize.titleize,
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
  Account => [{
    Asset      => ['Fixed Assets', 'Other Assets',
      {CurrentAsset => 
        [{Receivable => [{Customer => ['Customer 1']}]}]
      },
      {BankAccount => ['Bank Account 1', 'Bank Account 2']}
    ],
    Liability  => ['Long Term Liabilities',
      {CurrentLiability => [{Vendor => ['Electric Company']}]}
    ],
    Expense => ['Electricity', 'Bank Fees', 'Insurance'],
    Revenue => ['Professional Services'],
    Equity => []
    }]
})

Term.create(
  :terms => 'On receipt'
)
