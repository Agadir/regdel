class Account < ActiveRecord::Base
  include AccountMethods

  has_many :entry_amounts
  has_many :entries, :through => :entry_amounts
  has_many :statements
  has_many :balances

  serialize :attrs

  validates :name,
            :presence => true,
            :uniqueness => true

  validates :type,
            :presence => true,
            :exclusion => { :in => ['Account'] }

  acts_as_nested_set
  state_machine :initial => :active do

    event :hide do
      transition :to => :hidden
    end

    event :deactivate do
      transition :to => :inactive
    end

  end

  class << self
    def balance
     all.map(&:balance).sum 
    end
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

  def tree_balance
    children.map(&:balance).sum
  end

end
