class AddColumnMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :notification, :string
  end
end
