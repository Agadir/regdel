class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.integer :account_id
      t.integer :balance_in_cents
      t.date :date_of_balance
      t.string :source
      t.integer :created_by

      t.timestamps
    end
  end
end
