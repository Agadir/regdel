class ExternalAccount < ActiveRecord::Base
  belongs_to :account

  validate :validate_account_type, :inverse_of => :external_account

  def required_account_types
    [BankAccount, CreditCard]
  end

  def account_type_valid?
    required_account_types.include? account.class
  end
  
  def validate_account_type
    errors.add(:external_account, "must have one of the following types: #{required_account_types.map(&:name).map(&:titleize).to_sentence(:last_word_connector => ' or ').downcase}") unless account_type_valid?
  end

end
