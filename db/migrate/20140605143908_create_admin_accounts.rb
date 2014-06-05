class CreateAdminAccounts < ActiveRecord::Migration
  def change
    create_table :admin_accounts do |t|
      t.string :full_name, null: false
      t.string :username, null: false, unique: true
      t.string :password_digest, null: false, index: true
      t.boolean :is_active, default: true

      t.boolean :deletable, dafault: false

      t.timestamps
    end
  end
end
