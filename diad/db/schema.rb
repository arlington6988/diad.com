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

ActiveRecord::Schema.define(version: 20160719022506) do

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "total"
    t.text     "items",      default: "--- []\n"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "fans", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "zipcode"
    t.string   "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.string   "description"
    t.string   "size"
    t.string   "color"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "photo"
    t.integer  "cart_id"
    t.string   "displayprice"
  end

  add_index "items", ["cart_id"], name: "index_items_on_cart_id"

  create_table "shows", force: :cascade do |t|
    t.string   "date"
    t.string   "venue"
    t.string   "city"
    t.string   "tickets"
    t.string   "directions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "age"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "age"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
