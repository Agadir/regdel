class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :memo
      t.string :state
      t.integer :fiscal_period_id

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
