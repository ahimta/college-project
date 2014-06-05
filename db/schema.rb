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

ActiveRecord::Schema.define(version: 20140605143908) do

  create_table "admin_accounts", force: true do |t|
    t.string   "full_name",                      null: false
    t.string   "username",                       null: false
    t.string   "password_digest",                null: false
    t.boolean  "is_active",       default: true
    t.boolean  "deletable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_accounts", ["username", "password_digest"], name: "index_admin_accounts_on_username_and_password_digest"
  add_index "admin_accounts", ["username"], name: "index_admin_accounts_on_username", unique: true

  create_table "applicants", force: true do |t|
    t.string   "first_name",     null: false
    t.string   "last_name",      null: false
    t.string   "phone",          null: false
    t.string   "address",        null: false
    t.string   "specialization", null: false
    t.string   "degree",         null: false
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
