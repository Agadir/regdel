class Record < ActiveRecord::Base
  set_table_name 'transactions'
  belongs_to :entry
  belongs_to :account
end
