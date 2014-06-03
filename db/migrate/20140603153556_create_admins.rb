class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :full_name, null: false
      t.string :username, null: false, index: true, unique: true
      t.string :password_digest, null: false
      t.boolean :deletable, default: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
