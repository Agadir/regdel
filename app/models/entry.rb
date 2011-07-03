class Entry < ActiveRecord::Base
  has_many :entry_amounts
  has_many :accounts, :through => :entry_amounts
end
