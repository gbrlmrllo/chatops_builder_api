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

ActiveRecord::Schema.define(version: 2020_05_09_173536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "owner_id"], name: "index_apps_on_name_and_owner_id", unique: true
    t.index ["owner_id"], name: "index_apps_on_owner_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.text "token", null: false
    t.bigint "app_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["app_id"], name: "index_credentials_on_app_id"
  end

  create_table "event_schemas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.jsonb "schema"
    t.bigint "creator_id", null: false
    t.bigint "app_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["app_id"], name: "index_event_schemas_on_app_id"
    t.index ["creator_id"], name: "index_event_schemas_on_creator_id"
    t.index ["name", "creator_id"], name: "index_event_schemas_on_name_and_creator_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.jsonb "body", default: {}, null: false
    t.text "raw_data", null: false
    t.text "failure_reason"
    t.bigint "event_schema_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_schema_id"], name: "index_events_on_event_schema_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.string "name", null: false
    t.string "type"
    t.bigint "event_schema_id", null: false
    t.jsonb "extra_data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_schema_id"], name: "index_integrations_on_event_schema_id"
    t.index ["name", "event_schema_id"], name: "index_integrations_on_name_and_event_schema_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti"
    t.string "first_name"
    t.string "last_name"
    t.string "dni"
    t.string "passport_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apps", "users", column: "owner_id"
  add_foreign_key "credentials", "apps"
  add_foreign_key "event_schemas", "apps"
  add_foreign_key "event_schemas", "users", column: "creator_id"
  add_foreign_key "integrations", "event_schemas"
end
