DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/rbeans.sqlite3")

class RdMoney < String
    def no_d
        return (self.gsub(/[^0-9]/,'').to_i)
    end
end


class Account
  include DataMapper::Resource
  
  property :id,Serial
  property :number,String
  property :name,String
  property :type_id,Integer
  property :description,Text
  property :created_on,Integer
  property :closed_on,Integer
  property :hide,Boolean
  property :group_id,Integer
  has n, :credits
  has n, :debits
  has n, :ledgers
end

class Entry
  include DataMapper::Resource
  
  property :id,Serial
  property :memorandum,String
  property :status,Integer
  property :fiscal_period_id,Integer
  has n, :credits
  has n, :debits
  has n, :ledgers
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
  has 1, :ledgers
  belongs_to :entry
  belongs_to :account

  def to_usd
      return "%.2f" % (self.amount.to_r.to_d / 100)
  end
end

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
  belongs_to :amount
end

class Credit < Amount; end

class Debit < Amount; end

DataMapper.auto_upgrade!
