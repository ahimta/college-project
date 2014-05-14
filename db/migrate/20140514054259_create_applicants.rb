class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :specialization
      t.string :degree

      t.timestamps
    end
  end
end
