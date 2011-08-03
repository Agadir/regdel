require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  setup do
    @bank   = BankAccount.make
    @asset  = Asset.make
    @income = Revenue.make
    @card   = CreditCard.make
  end
  test "should not save entry without memo" do
    entry = Entry.new
    assert !entry.save
  end
  test "should not save a check without a bank account" do
    entry = Check.make 
    c = Credit.make(:entry => entry, :account => @income)
    d = Debit.make(:entry => entry, :account => @asset)
    assert !entry.save
  end
  test "should save check with everything in its right place" do
    entry = Check.make 
    c = entry.credits.build(:account => @income, :amount_in_cents => 12300)
    d = entry.debits.build(:account => @bank, :amount_in_cents => 12300)
    assert entry.save
  end
  test "should save transfer with everything in its right place" do
    entry = Transfer.make 
    c = entry.credits.build(:account => @card, :amount_in_cents => 12300)
    d = entry.debits.build(:account => @bank, :amount_in_cents => 12300)
    assert entry.save
  end
end
