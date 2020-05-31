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

ActiveRecord::Schema.define(version: 2020_05_31_165645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borutus_accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.boolean "contra", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "amounts_count"
    t.index ["name", "type"], name: "index_borutus_accounts_on_name_and_type"
  end

  create_table "borutus_amounts", id: :serial, force: :cascade do |t|
    t.string "type"
    t.integer "account_id"
    t.integer "entry_id"
    t.decimal "amount", precision: 20, scale: 10
    t.index ["account_id", "entry_id"], name: "index_borutus_amounts_on_account_id_and_entry_id"
    t.index ["entry_id", "account_id"], name: "index_borutus_amounts_on_entry_id_and_account_id"
    t.index ["type"], name: "index_borutus_amounts_on_type"
  end

  create_table "borutus_entries", id: :serial, force: :cascade do |t|
    t.string "description"
    t.date "date"
    t.integer "commercial_document_id"
    t.string "commercial_document_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commercial_document_id", "commercial_document_type"], name: "index_entries_on_commercial_doc"
    t.index ["date"], name: "index_borutus_entries_on_date"
  end

end
