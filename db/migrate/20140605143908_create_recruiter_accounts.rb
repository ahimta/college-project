class CreateRecruiterAccounts < ActiveRecord::Migration
  def change
    create_table :recruiter_accounts do |t|
      t.string :full_name, null: false
      t.string :username, null: false
      t.string :password_digest, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end

    add_index :recruiter_accounts, :username, unique: true
  end
end
