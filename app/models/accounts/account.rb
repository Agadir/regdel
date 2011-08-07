class Account < ActiveRecord::Base
  include AccountMethods

  ACCOUNT_TYPES = ["Asset", "Liability", "Equity", "Revenue", "Expense"]

  serialize :attrs

  validates :name,
            :presence => true,
            :uniqueness => true

  validates :type,
            :presence => true,
            :exclusion => { :in => ['Account'] }

  has_many :entries, :through => :entry_amounts
  has_many :entry_amounts

  acts_as_nested_set
  state_machine :initial => :active do
  end

  def as_base
    self.becomes(Account) 
  end

  def destroy
    false
  end

  def balance
    entry_amounts.sum(:amount_in_cents) * 0.01
  end

end
