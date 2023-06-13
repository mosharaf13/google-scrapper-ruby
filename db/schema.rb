# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_06_12_121926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "result_links", force: :cascade do |t|
    t.bigint "search_stat_id", null: false
    t.string "link_type", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["link_type"], name: "index_result_links_on_link_type"
    t.index ["search_stat_id"], name: "index_result_links_on_search_stat_id"
    t.index ["url"], name: "index_result_links_on_url"
  end

  create_table "search_stats", force: :cascade do |t|
    t.string "keyword", null: false
    t.integer "ad_count", default: 0, null: false
    t.integer "link_count", default: 0, null: false
    t.bigint "total_result_count", default: 0, null: false
    t.text "raw_response"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "non_ad_count", default: 0, null: false
    t.integer "top_ad_count", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.index ["status"], name: "index_search_stats_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "result_links", "search_stats"
  add_foreign_key "search_stats", "users"
end
