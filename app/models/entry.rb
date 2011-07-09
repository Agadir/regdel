class Entry < ActiveRecord::Base
  has_many :entry_amounts
  has_many :credits
  has_many :debits
  has_many :accounts, :through => :entry_amounts
  accepts_nested_attributes_for :credits
  accepts_nested_attributes_for :debits
  def destroy
    raise ActiveRecord::IndestructibleRecord
  end

end
