class ChangeColumnNameUsers < ActiveRecord::Migration
  def change
    rename_column :users, :email_address, :email
    rename_column :users, :password_digest, :crypted_password
    add_index :users, :email, unique: true
  end
end
