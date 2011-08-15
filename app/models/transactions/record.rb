class Record < ActiveRecord::Base
  set_table_name 'transactions'
  belongs_to :entry
  belongs_to :account

  class << self
    def transactions
      where(['type != "Proxy"'])
    end
  end


end
