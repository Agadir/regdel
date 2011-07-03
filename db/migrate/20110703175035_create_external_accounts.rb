class CreateExternalAccounts < ActiveRecord::Migration
  def change
    create_table :external_accounts do |t|
      t.integer :account_id
      t.integer :number
      t.string :type

      t.timestamps
    end
  end
end
