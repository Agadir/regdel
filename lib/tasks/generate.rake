namespace :generate do
  
  task :random_entries => :environment do

    (1..500).each do |i|
      banks = BankAccount.first.descendants
      bank  = banks[rand(banks.size)] 

      expenses = Expense.first.descendants
      expense  = expenses[rand(expenses.size)]
      expense2 = expenses[rand(expenses.size)]
      total_amount = rand(100000) * 0.01
      amount1 = total_amount - rand(5000) * 0.01
      amount2 = total_amount - amount1
      
      
      entry = Check.new(:memo => "Entry #{i}", :date => Time.now)
      c = entry.credits.build(:account => expense, :amount_in_cents => amount1)
      d = entry.debits.build(:account => bank, :amount_in_cents => total_amount)
      c2 = entry.credits.build(:account => expense2, :amount_in_cents => amount2)
      entry.save

    end
  end

end
