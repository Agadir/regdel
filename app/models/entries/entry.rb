class Entry < ActiveRecord::Base

  has_many :records, :inverse_of => :entry
  has_many :transactions
  has_many :proxies
  has_many :credits
  has_many :debits
  has_many :accounts, :through => :records

  accepts_nested_attributes_for :credits
  accepts_nested_attributes_for :debits
  accepts_nested_attributes_for :proxies

  validate :credits_and_debits_must_balance
  validate :entry_account_types_validation
  validate :transactions_valid?

  validates :memo,
            :presence => true

  validates :type,
            :presence => true,
            :exclusion => { :in => ['Entry'] }

  state_machine :entry_state, :initial => :draft do

    event :complete do
      transition :from => :draft, :to => :completed
    end

    event :post do
      transition :from => :completed, :to => :posted
    end

    event :reconcile do
      transition :from => :posted, :to => :reconciled
    end

    state :draft, :value => 0
    state :completed, :value => 10
    state :posted, :value => 20
    state :reconciled, :value => 30
  end

  class << self
    def before_date(date)
      where(["date <= ?", date])
    end
    def per_page 
      10
    end
  end

  def as_base
    self.becomes(Entry)
  end

  def destroy
    false
  end
  alias_method :destroy, :delete

  def amount
    self.credits.sum(:amount_in_cents) * 0.01
  end

  def balanced?
    credits.sum(:amount_in_cents) == debits.sum(:amount_in_cents)
  end

  def transactions_valid?
    errors.add(:transactions, "must be greater than zero") unless debits.length >= 1 && credits.length >= 1
  end

  def account_types_valid?
    pending_transactions.map(&:account).all?{|x| required_account_types.any?{|rq| x.is_a?(rq)}}
    #required_account_types.all?{|x| pending_transactions.map(&:account).include?(x) }
  end

  def credits_and_debits_must_balance
    unless draft?
      errors.add(:transactions, "must balance") unless balanced?
    else
      true
    end
  end

  def pending_transactions
    debits | credits
  end

  def entry_account_types_validation
    errors.add(:transactions, "accounts must have one of the following types: #{required_account_types.map(&:name).map(&:titleize).to_sentence(:last_word_connector => ' or ').downcase}") unless account_types_valid?
  end
end
