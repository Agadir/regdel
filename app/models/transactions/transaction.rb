class Transaction < Record
  
  validates :amount_in_cents,
            :presence => true,
            :numericality => true

  class << self
    def before_date(date)
      joins(:entry).merge(Entry.before_date(date))
    end
  end

  def amount_in_cents=(raw_amount)
    write_attribute(:amount_in_cents, raw_amount.to_f * 100)
  end

  def amount_in_cents
    if read_attribute(:amount_in_cents).present?
      read_attribute(:amount_in_cents) * 0.01
    else
      0
    end
  end
  def amount
    amount_in_cents
  end
end
