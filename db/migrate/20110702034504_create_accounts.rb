class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.integer :parent_id
      t.string :type
      t.integer :lft
      t.integer :rgt
      t.inactive :boolean
      t.description :text


      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
