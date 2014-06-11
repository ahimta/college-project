class CreateAdminAccounts < ActiveRecord::Migration
  def change
    create_table :admin_accounts do |t|
      t.string :full_name
      t.string :username
      t.string :password_digest
      t.boolean :is_active

      t.timestamps
    end
    add_index :admin_accounts, :username, unique: true
  end
end
