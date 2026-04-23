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

ActiveRecord::Schema[8.1].define(version: 2026_04_23_014211) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date"
    t.text "description"
    t.string "google_event_id"
    t.string "image"
    t.string "location"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "featured"
    t.string "icon"
    t.integer "position"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "news_articles", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "external_url"
    t.boolean "featured"
    t.string "image"
    t.datetime "published_date"
    t.string "source"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "news_feeds", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "featured", default: false, null: false
    t.datetime "published_at"
    t.string "subtitle"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["featured"], name: "index_posts_on_featured", unique: true, where: "(featured = true)"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "volunteer_interests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "volunteer_interests_volunteer_submissions", id: false, force: :cascade do |t|
    t.bigint "volunteer_interest_id", null: false
    t.bigint "volunteer_submission_id", null: false
  end

  create_table "volunteer_submission_interests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "volunteer_interest_id", null: false
    t.bigint "volunteer_submission_id", null: false
    t.index ["volunteer_interest_id"], name: "index_volunteer_submission_interests_on_volunteer_interest_id"
    t.index ["volunteer_submission_id"], name: "idx_on_volunteer_submission_id_ba6cecb055"
  end

  create_table "volunteer_submissions", force: :cascade do |t|
    t.string "area_code"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "last_name"
    t.text "message"
    t.string "name"
    t.string "phone"
    t.integer "status"
    t.integer "submission_status"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "posts", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "volunteer_interests_volunteer_submissions", "volunteer_interests", name: "fk_volunteer_interests"
  add_foreign_key "volunteer_interests_volunteer_submissions", "volunteer_submissions", name: "fk_volunteer_submissions"
  add_foreign_key "volunteer_submission_interests", "volunteer_interests"
  add_foreign_key "volunteer_submission_interests", "volunteer_submissions"
end
