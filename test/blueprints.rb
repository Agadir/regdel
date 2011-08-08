require 'machinist/active_record'

Asset.blueprint do
  name { "Photo Copier" }
end

BankAccount.blueprint do
  name { "National Bank" }
  number { 12345 }  
end

CreditCard.blueprint do
  name { "VISA Bank" }
  number { 12345 }  
end

Revenue.blueprint do
  name { "Hosting" }
end

Customer.blueprint do
  name { "ABC Customer" }
end

Expense.blueprint do
  name { "Electricity" }
end

Debit.blueprint do
  a = BankAccount.make
  account { a }
  amount_in_cents { 12300 }
end

Debit.blueprint(:customer) do
  a = Customer.make
  account { a }
  amount_in_cents { 12300 }
end

Credit.blueprint do
  a = Expense.make
  account { a }
  amount_in_cents { 12300 }
end

Credit.blueprint(:revenue) do
  a = Revenue.make
  account { a }
  amount_in_cents { 12300 }
end

Email.blueprint do
  address { 'test@test.com' }  
end

Check.blueprint do
  memo { 'Payment to someone' }
  date { Time.now }
end

Transfer.blueprint do
  memo { 'OK' }
  date { Time.now }
end

Invoice.blueprint do
  memo { 'OK' }
  date { Time.now }
end
