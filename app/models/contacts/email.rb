class Email < ActiveRecord::Base
  has_one :contactable, :foreign_key => :contact_id
end
