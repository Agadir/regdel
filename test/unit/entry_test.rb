require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  setup do
    @bank   = BankAccount.make
    @asset  = Asset.make
    @revenue = Revenue.make
    @expense = Expense.make
    @expense2 = Expense.make(:name => 'Phone')
    @card   = CreditCard.make
    @customer = Customer.make
  end
  test "should not save entry without memo" do
    entry = Entry.new
    assert !entry.save
  end
  test "should not save a check without a bank account" do
    entry = Check.make 
    c = Credit.make(:entry => entry, :account => @revenue)
    d = Debit.make(:entry => entry, :account => @asset)
    assert !entry.save
  end
  test "should save check with everything in its right place" do
    entry = Check.make 
    c = entry.credits.build(:account => @expense, :amount_in_cents => 12100)
    d = entry.debits.build(:account => @bank, :amount_in_cents => 12300)
    assert entry.draft?
    assert !entry.check_cleared?, "Not cleared"
    assert entry.save, "Can't save"
    assert !entry.balanced?
    c2 = entry.credits.build(:account => @expense2, :amount_in_cents => 200)
    assert entry.save
    assert entry.complete
    assert entry.issue_check!
    assert entry.posted?
  end
  test "should not save transfer with the wrong account types" do
    entry = Transfer.make
    c = entry.credits.build(:account => @expense, :amount_in_cents => 12300)
    d = entry.debits.build(:account => @customer, :amount_in_cents => 12300)
    assert !entry.save
  end
  test "should save transfer with everything in its right place" do
    entry = Transfer.make
    c = entry.credits.build(:account => @card, :amount_in_cents => 12300)
    d = entry.debits.build(:account => @bank, :amount_in_cents => 12300)
    assert entry.save
    assert entry.balanced?
  end
  test "should save invoice with everything in its right place" do
    entry = Invoice.make(:term_id => 1) 
    c = entry.credits.build(:account => @customer, :amount_in_cents => 12300)
    d = entry.debits.build(:account => @revenue, :amount_in_cents => 12300)
    assert entry.save
    assert entry.customer
    assert entry.balanced?
    assert entry.complete
  end
  test "should save credit card with everything in its right place" do
    entry = CreditCardCharge.make
    c = entry.credits.build(:account => @card, :amount_in_cents => 12300)
    d = entry.debits.build(:account => @expense, :amount_in_cents => 12300)
    assert entry.save
    assert entry.balanced?
    assert entry.complete
  end
end
