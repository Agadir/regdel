class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :number, :null=> true
      t.string :memo
      t.integer :entry_state
      t.integer :state
      t.date :date
      t.date :posted_date, :null=> true
      t.string :term_id, :null=> true
      t.integer :fiscal_period_id, :null=> true
      t.string :type
      t.boolean :posted, :null=> true 
      t.boolean :reconciled, :null=> true 

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
