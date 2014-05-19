class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.string :specialization, null: false
      t.string :degree, null: false

      t.boolean :accepted

      t.timestamps
    end
  end
end
