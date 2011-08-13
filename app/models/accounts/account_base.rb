class Base < ActiveRecord::Base
  set_table_name "accounts"

  ACCOUNT_TYPES = Account.root.children

  has_many :entry_amounts
  has_many :entries, :through => :entry_amounts do
    def non_reconciled_through_date(statement_date)
      all.reject{|e| e.reconciled || e.date > statement_date}
    end
  end
  has_many :statements
  has_many :balances

  serialize :attrs

  validates :name,
            :presence => true,
            :uniqueness => true

  validates :type,
            :presence => true

  validates :type,
            :uniqueness => true,
            :if => "type == 'Account'"

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

  def current_balance
    entry_amounts.sum(:amount_in_cents) * 0.01
  end

  def tree_balance
    children.map(&:balance).sum
  end

  def reconcile(statement_date, statement_balance)
    statement_balance = statement_balance.to_f * 100
    entries.non_reconciled_through_date(statement_date).each do |e|
      e.reconcile
    end
    balances.build(:date_of_balance => statement_date, :balance_in_cents => statement_balance)
    update_attribute(:last_reconciliation_date, statement_date)
  end

end
