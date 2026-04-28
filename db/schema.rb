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

ActiveRecord::Schema[8.1].define(version: 2026_04_28_171107) do
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

  create_table "ahoy_events", force: :cascade do |t|
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.bigint "user_id"
    t.bigint "visit_id"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "app_version"
    t.string "browser"
    t.string "city"
    t.string "country"
    t.string "device_type"
    t.string "ip"
    t.text "landing_page"
    t.float "latitude"
    t.float "longitude"
    t.string "os"
    t.string "os_version"
    t.string "platform"
    t.text "referrer"
    t.string "referring_domain"
    t.string "region"
    t.datetime "started_at"
    t.text "user_agent"
    t.bigint "user_id"
    t.string "utm_campaign"
    t.string "utm_content"
    t.string "utm_medium"
    t.string "utm_source"
    t.string "utm_term"
    t.string "visit_token"
    t.string "visitor_token"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
    t.index ["visitor_token", "started_at"], name: "index_ahoy_visits_on_visitor_token_and_started_at"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date"
    t.text "description"
    t.string "google_event_id"
    t.string "image"
    t.float "latitude"
    t.string "location"
    t.float "longitude"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "issue_news_articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "issue_id", null: false
    t.bigint "news_article_id", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id", "news_article_id"], name: "index_issue_news_articles_on_issue_id_and_news_article_id", unique: true
    t.index ["issue_id"], name: "index_issue_news_articles_on_issue_id"
    t.index ["news_article_id"], name: "index_issue_news_articles_on_news_article_id"
  end

  create_table "issues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "featured"
    t.string "icon"
    t.integer "position"
    t.integer "status"
    t.text "summary"
    t.text "tagline"
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

  create_table "site_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "key"
    t.datetime "updated_at", null: false
    t.text "value"
    t.index ["key"], name: "index_site_settings_on_key", unique: true
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
    t.datetime "welcome_email_sent_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "issue_news_articles", "issues"
  add_foreign_key "issue_news_articles", "news_articles"
  add_foreign_key "posts", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "volunteer_interests_volunteer_submissions", "volunteer_interests", name: "fk_volunteer_interests"
  add_foreign_key "volunteer_interests_volunteer_submissions", "volunteer_submissions", name: "fk_volunteer_submissions"
  add_foreign_key "volunteer_submission_interests", "volunteer_interests"
  add_foreign_key "volunteer_submission_interests", "volunteer_submissions"
end
