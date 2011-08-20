class Invoice < Entry

  belongs_to :term

  state_machine :initial => :open, :namespace => :invoice do

    event :issue do
      transition :open => :issued
    end

    event :pay do
      transition :issued => :paid
    end

    event :close do
      transition :paid => :closed
    end

    state :open, :value => 200
    state :voided, :value => 201
    state :cancelled, :value => 202
    state :issued, :value => 210
    state :paid, :value => 220
    state :closed, :value => 230

  end

  def customer
    accounts.select{|a| a.is_a?(Customer)}.first
  end

  def required_account_types
    [Revenue, Customer]
  end

end
