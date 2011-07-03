class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|

      t.references :contactable, :polymorphic => true
      t.timestamps
    end
  end
end
