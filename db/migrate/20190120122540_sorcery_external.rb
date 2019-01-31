class SorceryExternal < ActiveRecord::Migration[5.1]
  def change
    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :integer, :limit => 8 , :null => false

      t.timestamps              :null => false
    end

    add_index :authentications, [:provider, :uid]
  end
end
