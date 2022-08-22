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

ActiveRecord::Schema.define(version: 20220816174237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "menu_categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.string  "name",                       null: false
    t.integer "menu_category_id", limit: 8, null: false
    t.decimal "price",                      null: false
    t.string  "description"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id",           limit: 8,             null: false
    t.integer "menu_item_id",       limit: 8,             null: false
    t.string  "menu_item_name",                           null: false
    t.decimal "menu_item_price",                          null: false
    t.integer "menu_item_quantity",           default: 1
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",           limit: 8, null: false
    t.datetime "order_placed_date"
    t.string   "order_status",                null: false
  end

  create_table "todos", id: :bigserial, force: :cascade do |t|
    t.text     "todo_text"
    t.date     "due_date"
    t.boolean  "completed"
    t.integer  "user_id",    limit: 8
    t.datetime "created_at",           precision: 6
    t.datetime "updated_at",           precision: 6
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",             null: false
    t.string   "crypted_password",  null: false
    t.integer  "role",              null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_salt"
    t.string   "persistence_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
