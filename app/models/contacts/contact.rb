class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  has_many :emails

  accepts_nested_attributes_for :emails, :reject_if => :all_blank

end
