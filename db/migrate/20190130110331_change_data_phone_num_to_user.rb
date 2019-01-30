class ChangeDataPhoneNumToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :phone_num, :string
  end
end
