class EntryAmount < ActiveRecord::Base
  
  belongs_to :entry
  belongs_to :account

end
