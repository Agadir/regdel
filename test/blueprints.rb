require 'machinist/active_record'

Asset.blueprint do
  name { "Photo Copier" }
end

BankAccount.blueprint do
  name { "National Bank" }
  number { 12345 }  
end

Revenue.blueprint do
  name { "Hosting" }
end

Expense.blueprint do
  name { "Electricity" }
end

Debit.blueprint do
  amount_in_cents { 123 }
end

Credit.blueprint do
  amount_in_cents { 123 }
end

Check.blueprint do
  memo { 'Payment to someone' }
  date { Time.now }
end

Invoice.blueprint do

end
