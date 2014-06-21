class CreateApplicantJobRequests < ActiveRecord::Migration
  def change
    create_table :applicant_job_requests do |t|
      t.string :specialization, null: false
      t.string :full_name, null: false
      t.string :address, null: false
      t.string :degree, null: false
      t.string :phone, null: false

      t.attachment :bachelor_certificate
      t.attachment :master_certificate
      t.attachment :doctorate_certificate
      t.attachment :bachelor_certificate
      t.attachment :cv

      t.boolean :accepted

      t.timestamps
    end
  end
end
