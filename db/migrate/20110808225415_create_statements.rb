class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :account_id
      t.date :from_date
      t.date :to_date
      t.boolean :active
      t.text :description

      t.timestamps
    end
  end
end
