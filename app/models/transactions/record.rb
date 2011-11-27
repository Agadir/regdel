class Record < ActiveRecord::Base
  set_table_name 'transactions'
  belongs_to :entry, :inverse_of => :records
  belongs_to :account, :inverse_of => :records

  delegate :name, :to => :account, :prefix => true


end
