DataMapper.setup(:default, 'sqlite3:///var/www/dev/regdel/rbeans.sqlite3')



class Account
  include DataMapper::Resource

  name_length_error = "Name is too long or too short."
  property :id,Serial
  property :number,String
  property :name,String
  property :type_id,Integer
  property :description,Text
  property :created_on,Integer, :default => Time.now.to_i
  property :closed_on,Integer, :default => 0
  property :hide,Boolean
  property :group_id,Integer
  property :cached_journal_balance,Integer
  has n, :credits
  has n, :debits
  has n, :ledgers
  validates_present :name
  validates_length :name, :max => 12, :message => name_length_error
  validates_length :name, :min => 2, :message => name_length_error
  validates_is_unique :name


    
  def self.open
    all(:closed_on => 0)
  end
  def journal_balance_usd
    credit_sum = self.credits.sum(:amount) ? self.credits.sum(:amount) : 0
    debit_sum = self.debits.sum(:amount) ? self.debits.sum(:amount) : 0
    
    return "%.2f" % ((credit_sum + debit_sum).to_r.to_d / 100)
  end
  def journal_balance
    credit_sum = self.credits.sum(:amount) ? self.credits.sum(:amount) : 0
    debit_sum = self.debits.sum(:amount) ? self.debits.sum(:amount) : 0

    return (credit_sum + debit_sum)
  end
  def ledger_balance_usd
    ledger_sum = self.ledgers.sum(:amount) ? self.ledgers.sum(:amount) : 0
    
    return "%.2f" % (ledger_sum.to_r.to_d / 100)
  end
end

class Entry
  include DataMapper::Resource

  property :id,Serial
  property :memorandum,String
  property :status,Integer
  property :fiscal_period_id,Integer
  property :entered_on,Integer, :default => Time.now.to_i
  has n, :credits
  has n, :debits
  has n, :ledgers
  
  def credit_sum
    # Does not work: 
    # !! Unexpected error while processing request: 
    # +options[:fields]+ entry #<DataMapper::Property @model=Amount @name=:amount>
    # does not map to a property in Credit
    return "%.2f" % (Credit.sum(:amount, :entry_id => self.id).to_r.to_d / 100)
    
    # Works fine, but isn't it the same thing?
    #return Amount.sum(:amount, :type => 'Credit', :entry_id => self.id)
  end

end

class Amount
  include DataMapper::Resource

  property :id,Serial
  property :entry_id,Integer
  property :type,Discriminator
  property :amount,Integer
  property :account_id,Integer
  property :memorandum,String
  property :currency_id,Integer
  belongs_to :entry, :model => 'Entry', :child_key => [:entry_id, Integer]


  def to_usd
      return "%.2f" % (self.amount.to_r.to_d / 100)
  end
  def self.sum_usd
    return self.entry.credits.sum(:amount)
  end

end


class Credit < Amount; end

class Debit < Amount; end

class Ledger
  include DataMapper::Resource

  property :id,Serial
  property :posted_on,Integer
  property :memorandum,String
  property :amount,Integer
  property :account_id,Integer
  property :entry_id,Integer
  property :entry_amount_id,Integer
  property :fiscal_period_id,Integer
  property :currency_id,Integer
  belongs_to :account
  belongs_to :entry
  belongs_to :entry_amount, :model => 'Amount', :child_key => [ :entry_amount_id ]
  
  def to_usd
      return "%.2f" % (self.amount.to_r.to_d / 100)
  end
  # Called from a Ledger instance object, returns the ledger balance for that entry
  def running_balance
    return "%.2f" % ( (Ledger.all(
      :conditions => ["account_id = ? AND ( posted_on < ? OR (( posted_on = ? AND amount < ? ) OR ( posted_on = ? AND amount = ? AND id < ?)))", self.account_id,  self.posted_on, self.posted_on, self.amount, self.posted_on, self.amount, self.id] ).sum(:amount).to_i.to_r.to_d + self.amount) / 100)
  end
end


DataMapper.auto_upgrade!
