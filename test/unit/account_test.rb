require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "should not save account without name" do
    acc = Account.new
    assert !acc.save
  end

end
