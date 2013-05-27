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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130525213809) do

  create_table "addresses", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "organisation"
    t.string   "building"
    t.string   "street"
    t.string   "town"
    t.string   "city"
    t.string   "county"
    t.string   "post_code"
    t.string   "country"
    t.string   "phone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
    t.string   "type"
  end

  create_table "basket_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "basket_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "qty",        :default => 1
  end

  create_table "baskets", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.integer  "qty",        :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "delivery_address_id"
    t.integer  "stage",               :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "order_id"
    t.string   "card_type"
    t.string   "card_number"
    t.date     "expiry_date"
    t.integer  "billing_address_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_sessions", ["session_id"], :name => "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
