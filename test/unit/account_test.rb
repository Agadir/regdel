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
      @asset.save
      @entry.save
      @bank = BankAccount.make
    end
    should "have a balance, and a tree balance" do
      assert !@asset.current_balance.nil?
      assert !@asset.tree_balance.nil?
    end
    should "have a balance at a date" do
      assert @asset.balance_as_of(Date.tomorrow)
    end
    should "have reconciled balances" do
      b = Balance.make({:account_id => @asset.id})
      b.save
      @asset.reload
      assert @asset.balances.present?
    end
    should "should have children" do
      assert !@asset.children.nil?
    end
    should "should have a level" do
      assert @asset.level.is_a?(Integer)
    end
    should "have an external account" do
      a = @bank.build_external_account({:number => 12345})
      a.save
      assert @bank.external_account
    end
    should "should not get destroyed" do
      assert !@asset.destroy
    end
    should "reconcile" do
      assert @asset.reconcile(Date.today, '123.00')
    end
    should "hide" do
      assert @asset.hide
    end
  end

end
