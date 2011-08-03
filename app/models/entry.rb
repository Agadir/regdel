class Entry < ActiveRecord::Base
  has_many :entry_amounts
  has_many :credits
  has_many :debits
  has_many :accounts, :through => :entry_amounts, :polymorphic => true
  accepts_nested_attributes_for :credits
  accepts_nested_attributes_for :debits

  validate :credits_and_debits_must_balance, :if => :posted?
  validate :account_types_valid?
  validate :entry_amounts_valid?

  validates :memo,
            :presence => true

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

  def entry_amounts_valid?
    errors.add(:entry_amounts, "must be greater than zero") unless debits.length >= 1 && credits.length >= 1
  end

  def account_types_valid?
    false  
  end

  def credits_and_debits_must_balance
    errors.add(:entry_amounts, "must balance") unless credits.sum(:amount_in_cents) == debits.sum(:amount_in_cents)
  end

end
