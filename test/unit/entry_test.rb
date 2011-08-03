require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  setup do
    @bank   = BankAccount.make
    @income = Revenue.make
  end
  test "should not save entry without memo" do
    entry = Entry.new
    assert !entry.save
  end
  test "should save entry with everything " do
    entry = Check.make 
    c = Credit.make(:entry => entry, :account => @income)
    d = Debit.make(:entry => entry, :account => @bank)
    assert entry.save
  end
end
