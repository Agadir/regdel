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

  #serialize :attrs

  validates :parent_id,
            :presence => true,
            :unless => Proc.new {|a| Account.count == 0 }

  validates :name,
            :presence => true,
            :uniqueness => true

  validates :type,
            :presence => true

  validates :type,
            :uniqueness => true,
            :if => "type == 'Account'"


  acts_as_nested_set

  state_machine :initial => :shown do

    event :hide do
      transition :from => :shown, :to => :hidden
    end

    event :show do
      transition :from => :hidden, :to => :shown
    end

  end

  class << self
    include CacheAPI

    def orphans
      where(:parent_id => nil)
    end

    def viewable
      where("inactive = ? AND state != ? AND parent_id > ?", false, 'hidden', 0)
    end
    def account_tree
      tree = {}
      Account.each_with_level(Account.root.descendants) {|x,y| tree[x] = y }
      tree
    end

    def levels_of_sub_accounts
      Account.map_with_level(Account.root.descendants) {|x,y| y}.max
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

  def parent_id=(id=nil)
    if id.present? || AccountBase.count == 0 
      write_attribute(:parent_id, id) 
    else
      write_attribute(:parent_id, 1)
    end
  end

  def height(mydepth=level)
    Account.levels_of_sub_accounts + 1 - mydepth
  end

  def current_balance
    sub = transactions.sum(:amount_in_cents) * 0.01
    if self.has_descendants?
      sub = sub + self.children.map(&:current_balance).sum
    end
    sub
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
