class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_num, :integer
    add_column :users, :gender, :string
    add_column :users, :web, :string
    
    add_index :users , [:name, :phone_num, :gender, :web]
  end
end
