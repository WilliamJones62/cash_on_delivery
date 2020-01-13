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

ActiveRecord::Schema.define(version: 20191216211456) do

  create_table "cod_accounts", force: :cascade do |t|
    t.date "ship_date"
    t.string "invoice_numb"
    t.string "route_code"
    t.string "cust_code"
    t.string "cust_name"
    t.string "cost_ctr"
    t.datetime "logistics_complete_date"
    t.datetime "accounting_complete_date"
    t.string "reason_code"
    t.string "reason_details"
    t.boolean "logistics_completed"
    t.boolean "accounting_completed"
    t.string "logistics_agent"
    t.string "received_as"
    t.float "amount_owed"
    t.float "amount_extra"
    t.float "amount_received"
    t.float "amount_credit"
    t.float "credit_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "check_numb"
    t.text "notes"
  end

  create_table "invheads", force: :cascade do |t|
    t.string "invoice_numb"
    t.string "order_numb"
    t.string "rel_numb"
    t.date "ship_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "terms_code"
    t.string "cost_ctr"
  end

  create_table "invheadviews", force: :cascade do |t|
    t.string "invoice_numb"
    t.string "order_numb"
    t.string "rel_numb"
    t.date "ship_date"
    t.float "sub_total"
    t.float "charged_frt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ordheads", force: :cascade do |t|
    t.string "order_numb"
    t.string "rel_numb"
    t.string "cost_ctr"
    t.string "cust_name"
    t.string "route_code"
    t.string "cust_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "cod"
    t.string "cod_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
