class EntryAmount < ActiveRecord::Base
  
  validates :amount_in_cents,
            :presence => true,
            :numericality => true


  belongs_to :entry
  belongs_to :account

  def amount_in_cents=(amount_in_cents)
    write_attribute(:amount_in_cents, amount_in_cents.to_f * 100)
  end

  def amount
    amount_in_cents * 0.01
  end
end
