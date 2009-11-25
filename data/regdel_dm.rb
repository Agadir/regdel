DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/rbeans.sqlite3")

class String
    def to_cents
        return (self * 100).to_i
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
end

class Entry
  include DataMapper::Resource
  
  property :id,Serial
  property :memorandum,String
  property :status,Integer
  property :fiscal_period_id,Integer
  has n, :credits
  has n, :debits
end

class Amount
  include DataMapper::Resource
  
  property :id,Serial
  property :entry_id,Integer
  property :type,Discriminator
  property :amount,Integer
  property :account_id,Integer
  property :memorandum,String
  belongs_to :entry
  belongs_to :account
end

class Credit < Amount; end

class Debit < Amount; end

DataMapper.auto_upgrade!
