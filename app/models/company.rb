class Company < ActiveRecord::Base

  validates :name,   
            :presence => true,   
            :uniqueness => true

  has_many :accounts, :as => :accountable

  state_machine :initial => :active do

  end

end
