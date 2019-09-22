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

ActiveRecord::Schema.define(version: 2019_09_22_144438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borutus_accounts", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.string "type", limit: 32, null: false
    t.integer "reference_id"
    t.string "reference_type", limit: 32
    t.decimal "balance", precision: 20, scale: 2, default: "0.0", null: false
    t.boolean "contra", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "overdraft_enabled", default: false, null: false
    t.index ["name", "reference_id", "reference_type"], name: "uindex", unique: true
  end

  create_table "borutus_amounts", force: :cascade do |t|
    t.string "type"
    t.bigint "account_id"
    t.bigint "entry_id"
    t.decimal "amount", precision: 20, scale: 10
    t.index ["account_id", "entry_id"], name: "index_borutus_amounts_on_account_id_and_entry_id"
    t.index ["account_id"], name: "index_borutus_amounts_on_account_id"
    t.index ["entry_id", "account_id"], name: "index_borutus_amounts_on_entry_id_and_account_id"
    t.index ["entry_id"], name: "index_borutus_amounts_on_entry_id"
    t.index ["type"], name: "index_borutus_amounts_on_type"
  end

  create_table "borutus_entries", force: :cascade do |t|
    t.integer "reference_id"
    t.string "reference_type", limit: 32
    t.string "kind"
    t.string "description", null: false
    t.datetime "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_entry_id"
    t.integer "inverse_entry_id"
    t.index ["parent_entry_id"], name: "index_borutus_entries_on_parent_entry_id"
    t.index ["reference_id", "reference_type", "id"], name: "rindex"
  end

  create_table "borutus_items", force: :cascade do |t|
    t.bigint "entry_id", null: false
    t.bigint "account_id", null: false
    t.boolean "debit", null: false
    t.string "comment"
    t.decimal "amount", precision: 20, scale: 2, default: "0.0", null: false
    t.decimal "balance", precision: 20, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_borutus_items_on_account_id"
    t.index ["entry_id"], name: "index_borutus_items_on_entry_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
