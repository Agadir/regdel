class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :type
      t.string :state
      t.integer :group_id
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
