# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_18_134759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.integer "block"
    t.integer "number"
    t.integer "space"
    t.integer "price"
    t.boolean "is_sold"
    t.boolean "reserved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
    t.integer "order_id"
    t.integer "client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "id_number"
    t.string "phone_number"
    t.integer "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "secret"
  end

  create_table "orders", force: :cascade do |t|
    t.date "contract_start_date"
    t.date "contract_end_date"
    t.boolean "is_active"
    t.boolean "completed"
    t.string "payment_type"
    t.integer "in_advance_payment"
    t.integer "apartment_space_sum"
    t.integer "parking_space_sum"
    t.integer "apartment_price_sum"
    t.integer "parking_price_sum"
    t.integer "full_price_sum"
    t.integer "user_id"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
  end

  create_table "parkings", force: :cascade do |t|
    t.integer "block"
    t.integer "number"
    t.integer "space"
    t.integer "price"
    t.boolean "is_sold"
    t.boolean "reserved"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "order_id"
    t.integer "client_id"
  end

  create_table "payment_schedules", force: :cascade do |t|
    t.json "schedule", default: {}
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "tokens", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
  end

end
