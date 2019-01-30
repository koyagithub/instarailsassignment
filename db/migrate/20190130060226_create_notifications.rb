class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :n_comment

      t.timestamps
    end
    add_index :notifications , [:n_comment]
  end
end
