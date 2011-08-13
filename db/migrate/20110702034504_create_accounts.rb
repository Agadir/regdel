class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.integer :number
      t.integer :integer
      t.integer :parent_id
      t.string :type
      t.integer :lft
      t.integer :rgt
      t.string :state
      t.text :description
      t.text :attrs
      t.boolean :inactive
      t.date :last_reconciliation_date

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
