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

ActiveRecord::Schema.define(version: 20150221204240) do

  create_table "social_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "social_id"
    t.string   "social_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_accounts", ["user_id"], name: "index_social_accounts_on_user_id"

  create_table "user_social_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "social_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_social_accounts", ["social_account_id"], name: "index_user_social_accounts_on_social_account_id"
  add_index "user_social_accounts", ["user_id"], name: "index_user_social_accounts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
