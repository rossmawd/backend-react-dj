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

ActiveRecord::Schema.define(version: 2019_08_12_174841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dislikes", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_dislikes_on_listing_id"
    t.index ["user_id"], name: "index_dislikes_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_likes_on_listing_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "url"
    t.bigint "playlist_id"
    t.integer "position"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "suggestion"
    t.index ["playlist_id"], name: "index_listings_on_playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "party"
    t.string "genre"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "dislikes", "listings"
  add_foreign_key "dislikes", "users"
  add_foreign_key "likes", "listings"
  add_foreign_key "likes", "users"
  add_foreign_key "listings", "playlists"
  add_foreign_key "playlists", "users"
end
