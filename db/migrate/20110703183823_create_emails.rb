class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.boolean :verified

      t.timestamps
    end
  end
end
