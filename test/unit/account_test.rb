require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "should not save account without name" do
    acc = Account.new
    assert !acc.save
  end

#  test "should not save account with type Account" do
#    acc = Account.new({:name => 'Blah'})
#    assert !acc.save
#  end

  test "should calculate the account balance" do
    acc = Asset.make 
  end

  context "existing accounts" do    
    setup do
      @asset = Asset.make({:name => 'Computer'})
      @entry = Check.make({
      })
    end
    should "should have a balance, and a tree balance" do
      assert !@asset.current_balance.nil?
      assert !@asset.tree_balance.nil?
    end
    should "should have children" do
      assert !@asset.children.nil?
    end
    should "should not get destroyed" do
      assert !@asset.destroy
    end
    should "reconcile" do
      assert @asset.reconcile(Date.today, '123.00')
    end
  end

end
