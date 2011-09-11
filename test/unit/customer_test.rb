require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @revenue = Revenue.make
    @customer = Customer.make
  end
  test "should have no emails" do
    assert !@customer.emails.present?
  end
  test "should have a contact" do
    c = Email.make
    assert !@customer.emails.nil?
  end
end
