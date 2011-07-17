require 'machinist/active_record'

Asset.blueprint do
  name { "Photo Copier" }
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
