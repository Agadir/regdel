task :default do
    puts "hi"
end


task :create_dummy_accounts do
  load('scripts/default_accounts.rb')

end

task :create_dummy_entries do
  require 'data/regdel_dm'
  for i in 1..20
      mycents = rand(8)
      @entry = Entry.new(:memorandum => "Hi #{i}",:entered_on => Time.now.to_i)
      @entry.save
      @entry.credits.create(:amount => RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 1)
      @entry.debits.create(:amount => RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 2)
  end
end
