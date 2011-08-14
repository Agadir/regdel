class Transaction < ActiveRecord::Base
  
  validates :amount_in_cents,
            :presence => true,
            :numericality => true

  before_validation :calculate_amount

  belongs_to :entry
  belongs_to :account

  def calculate_amount
    amount_in_cents = entry.amount if amount_in_cents.nil? && instance_of?(Proxy)
  end

  def amount_in_cents=(amount_in_cents)
    write_attribute(:amount_in_cents, amount_in_cents.to_f * 100)
  end

  def amount
    amount_in_cents * 0.01
  end
end
