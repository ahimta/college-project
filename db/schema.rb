# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140611105715) do

  create_table "admin_accounts", force: true do |t|
    t.string   "full_name",                      null: false
    t.string   "username",                       null: false
    t.string   "password_digest",                null: false
    t.boolean  "is_active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_accounts", ["username"], name: "index_admin_accounts_on_username", unique: true

  create_table "applicant_job_requests", force: true do |t|
    t.string   "specialization",                     null: false
    t.string   "full_name",                          null: false
    t.string   "address",                            null: false
    t.string   "degree",                             null: false
    t.string   "phone",                              null: false
    t.string   "bachelor_certificate_file_name"
    t.string   "bachelor_certificate_content_type"
    t.integer  "bachelor_certificate_file_size"
    t.datetime "bachelor_certificate_updated_at"
    t.string   "master_certificate_file_name"
    t.string   "master_certificate_content_type"
    t.integer  "master_certificate_file_size"
    t.datetime "master_certificate_updated_at"
    t.string   "doctorate_certificate_file_name"
    t.string   "doctorate_certificate_content_type"
    t.integer  "doctorate_certificate_file_size"
    t.datetime "doctorate_certificate_updated_at"
    t.string   "cv_file_name"
    t.string   "cv_content_type"
    t.integer  "cv_file_size"
    t.datetime "cv_updated_at"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruiter_accounts", force: true do |t|
    t.string   "full_name",                      null: false
    t.string   "username",                       null: false
    t.string   "password_digest",                null: false
    t.boolean  "is_active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recruiter_accounts", ["username"], name: "index_recruiter_accounts_on_username", unique: true

end
