class CreateEntryAmounts < ActiveRecord::Migration
  def change
    create_table :entry_amounts do |t|
      t.integer :account_id
      t.integer :entry_id
      t.integer :amount_in_cents
      t.integer :currency_id
      t.string :type

      t.timestamps
    end
  end
end
