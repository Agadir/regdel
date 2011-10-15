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

ActiveRecord::Schema.define(:version => 20110811010422) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "integer"
    t.integer  "parent_id"
    t.string   "type"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "state"
    t.text     "description"
    t.text     "attrs"
    t.boolean  "inactive",                 :default => false, :null => false
    t.date     "last_reconciliation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "balances", :force => true do |t|
    t.integer  "account_id"
    t.integer  "balance_in_cents"
    t.date     "date_of_balance"
    t.string   "source"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "state"
    t.integer  "group_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.integer  "company_id"
    t.string   "address"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", :force => true do |t|
    t.integer  "number"
    t.string   "memo"
    t.integer  "entry_state"
    t.integer  "state"
    t.date     "date"
    t.date     "posted_date"
    t.string   "term_id"
    t.integer  "fiscal_period_id"
    t.string   "type"
    t.boolean  "posted"
    t.boolean  "reconciled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_accounts", :force => true do |t|
    t.integer  "account_id"
    t.integer  "number"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_numbers", :force => true do |t|
    t.string   "type"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statements", :force => true do |t|
    t.integer  "account_id"
    t.date     "from_date"
    t.date     "to_date"
    t.boolean  "active"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "account_id"
    t.integer  "entry_id"
    t.integer  "amount_in_cents", :default => 0
    t.integer  "currency_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
