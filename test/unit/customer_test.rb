require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @revenue = Revenue.make
    @customer = Customer.make
  end
  test "should not save entry without memo" do
    entry = Invoice.new
    assert !entry.save
  end
end
