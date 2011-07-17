class EntryAmount < ActiveRecord::Base
  
  belongs_to :entry
  belongs_to :account

  before_validation do
    self.amount_in_cents = amount_in_cents * 100
  end

  def amount
    self.amount_in_cents * 0.01
  end
end
