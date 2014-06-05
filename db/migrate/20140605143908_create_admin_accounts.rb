class CreateAdminAccounts < ActiveRecord::Migration
  def change
    create_table :admin_accounts do |t|
      t.string :full_name, null: false
      t.string :username, null: false
      t.string :password_digest, null: false
      t.boolean :is_active, default: true

      t.boolean :deletable, dafault: false

      t.timestamps
    end

    add_index :admin_accounts, [:username, :password_digest]
    add_index :admin_accounts, :username, unique: true
  end
end
