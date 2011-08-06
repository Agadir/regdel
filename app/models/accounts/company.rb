class Company < Account

  has_many :contacts, :as => :contactable

end
