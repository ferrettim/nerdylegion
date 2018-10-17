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

ActiveRecord::Schema.define(version: 2018_10_17_180131) do

  create_table "abouts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bannerurl"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.integer "visit_id"
    t.integer "user_id"
    t.string "name"
    t.text "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "podcast_id"
    t.integer "episode"
    t.string "title"
    t.text "description"
    t.datetime "published_on"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "audiourl"
    t.string "download_size"
    t.string "duration"
    t.string "path"
    t.string "explicit"
    t.string "itunestype"
    t.string "episodetype"
    t.integer "thisweek", default: 0
    t.integer "thismonth", default: 0
    t.text "shownotes"
    t.index ["published_on", "title", "status"], name: "index_episodes_on_published_on_and_title_and_status"
  end

  create_table "host_options", force: :cascade do |t|
    t.integer "user_id"
    t.integer "podcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_host_options_on_podcast_id"
    t.index ["user_id"], name: "index_host_options_on_user_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "genre"
    t.string "language"
    t.boolean "mature"
    t.string "status"
    t.datetime "published_on"
    t.string "twitter"
    t.string "google"
    t.string "itunes"
    t.string "stitcher"
    t.string "tunein"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "path"
    t.string "slug"
    t.integer "user_id"
    t.integer "producer_id"
    t.integer "user2_id"
    t.integer "user3_id"
    t.string "patreon"
    t.string "logourl"
    t.integer "today"
    t.integer "yesterday"
    t.integer "thisweek"
    t.integer "lastweek"
    t.integer "thismonth"
    t.integer "lastmonth"
    t.integer "average"
    t.string "youtube"
    t.integer "subscribers", default: 0
    t.string "spotify"
    t.index ["producer_id"], name: "index_podcasts_on_producer_id"
    t.index ["slug"], name: "index_podcasts_on_slug", unique: true
    t.index ["title", "published_on", "status"], name: "index_podcasts_on_title_and_published_on_and_status"
    t.index ["user2_id"], name: "index_podcasts_on_user2_id"
    t.index ["user3_id"], name: "index_podcasts_on_user3_id"
    t.index ["user_id"], name: "index_podcasts_on_user_id"
  end

  create_table "privacies", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "twitter"
    t.string "provider"
    t.string "uid"
    t.string "imageurl"
    t.boolean "admin", default: false, null: false
    t.boolean "podcaster", default: false, null: false
    t.boolean "analytics", default: false, null: false
    t.index ["email", "admin"], name: "index_users_on_email_and_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.integer "user_id"
    t.string "referring_domain"
    t.string "search_keyword"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.integer "screen_height"
    t.integer "screen_width"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true
  end

end
