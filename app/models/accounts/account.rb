class Account < AccountBase

  has_one :external_account, :inverse_of => :account

  has_many :records, :inverse_of => :account
  has_many :transactions
  has_many :proxies
  has_many :credits
  has_many :debits
  has_many :entries, :through => :records do
    def non_reconciled_through_date(statement_date)
      all.reject{|e| e.reconciled || e.date > statement_date}
    end
  end
  has_many :statements
  has_many :balances

  accepts_nested_attributes_for :external_account

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
      transition :from => :active, :to => :hidden
    end

    event :show do
      transition :from => :hidden, :to => :active
    end

    event :deactivate do
      transition :to => :inactive
    end

    event :activate do
      transition :to => :active
    end
  end

  class << self
    include CacheAPI

    def account_tree
      tree = {}
      Account.each_with_level(Account.root.descendants) {|x,y| tree[x] = y }
      tree
    end

    def levels_of_sub_accounts
      depths = []
      account_tree.values.max
    end

    def account_type_names
      Account.root.children.map(&:name)
    end

    def sub_accounts_results
      Account.root.children.map(&:descendants).flatten
    end

    def accounts_root
      capi_get_or_set('accounts_root', Proc.new{ Account.root })
    end

    def account_types
      capi_get_or_set('account_types', Account,  :account_type_names)
    end

    def sub_accounts
      capi_get_or_set('sub_accounts', Account, :sub_accounts_results)
    end

    def balance
     all.map(&:balance).sum 
    end
    
  end

  def as_base
    self.becomes(Account) 
  end

  def find
    super
  end

  def destroy
    false
  end

  def depth
    parent.present? ? 1 + parent.depth : 0
  end

  def height(mydepth=depth)
    Account.levels_of_sub_accounts + 1 - mydepth
  end

  def current_balance
    transactions.sum(:amount_in_cents) * 0.01
  end

  def balance_as_of(date)
    transactions.before_date(date).sum(:amount_in_cents) * 0.01
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
