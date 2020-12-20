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

ActiveRecord::Schema.define(version: 2020_12_20_185921) do

  create_table "deputies", force: :cascade do |t|
    t.string "full_name"
    t.string "cpf"
    t.string "political_party"
    t.integer "registered_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_deputies_on_cpf"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "description"
    t.string "provider"
    t.string "provider_cnpj"
    t.string "issue_date"
    t.float "net_value"
    t.string "document_url"
    t.integer "deputy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_invoices_on_deputy_id"
  end

  add_foreign_key "invoices", "deputies"
end
