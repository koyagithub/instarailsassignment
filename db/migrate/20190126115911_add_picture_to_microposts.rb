class AddPictureToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :picture, :string
    add_index :microposts, [:picture]
  end
end
