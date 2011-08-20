class Balance < ActiveRecord::Base
  belongs_to :account

  validates :balance_in_cents,
    :presence => true,
    :numericality => true

end
