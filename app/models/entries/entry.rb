class Entry < ActiveRecord::Base
  has_many :entry_amounts
  has_many :credits
  has_many :debits
  has_many :accounts, :through => :entry_amounts

  accepts_nested_attributes_for :credits
  accepts_nested_attributes_for :debits
  accepts_nested_attributes_for :entry_amounts

  validate :credits_and_debits_must_balance, :if => :posted?
  validate :entry_account_types_validation
  validate :entry_amounts_valid?

  validates :memo,
            :presence => true

  validates :type,
            :presence => true,
            :exclusion => { :in => ['Entry'] }


  state_machine :initial => :active do
  end

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
    pending_entry_amounts.map(&:account).all?{|x| required_account_types.include?(x.class)}
    #required_account_types.all?{|x| pending_entry_amounts.map(&:account).include?(x) }
  end

  def credits_and_debits_must_balance
    errors.add(:entry_amounts, "must balance") unless credits.sum(:amount_in_cents) == debits.sum(:amount_in_cents)
  end

  def pending_entry_amounts
    debits | credits
  end

  def entry_account_types_validation
    []
  end

end
