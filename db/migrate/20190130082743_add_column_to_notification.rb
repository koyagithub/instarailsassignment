class AddColumnToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :user_id, :integer
  end
end
