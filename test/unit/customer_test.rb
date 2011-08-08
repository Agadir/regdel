require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @revenue = Revenue.make
    @customer = Customer.make
  end
  test "should have no contacts" do
    assert !@customer.contacts.present?
  end
  test "should have a contact" do
    c = Email.make
    assert !@customer.contacts.nil?
  end
end
