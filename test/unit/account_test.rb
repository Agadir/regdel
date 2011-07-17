require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "should not save account without name" do
    acc = Account.new
    assert !acc.save
  end
  test "should not save account with type Account" do
    acc = Account.new({:name => 'Blah'})
    assert !acc.save
  end

  test "should calculate the account balance" do
    acc = Asset.make 
  end
end
