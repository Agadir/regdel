require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "should not save account without name" do
    acc = Account.new({:name => 'Blah'})
    assert !acc.save
  end

end
