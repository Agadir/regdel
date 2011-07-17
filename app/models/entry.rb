class Entry < ActiveRecord::Base
  has_many :entry_amounts
  has_many :credits
  has_many :debits
  has_many :accounts, :through => :entry_amounts
  accepts_nested_attributes_for :credits
  accepts_nested_attributes_for :debits

  validates_size_of :credits, :minimum => 1
  validates_size_of :debits, :minimum => 1
  validate :credits_and_debits_must_balance, :if => :posted?

  validates :type,
            :presence => true,
            :exclusion => { :in => ['Entry'] }

  def as_base
    self.becomes(Entry)
  end

  def destroy
    false
  end

  def amount
    self.credits.sum(:amount_in_cents) * 0.01
  end

private

  def credits_and_debits_must_balance
    credits.sum(:amount_in_cents) == debits.sum(:amount_in_cents)
  end

end
