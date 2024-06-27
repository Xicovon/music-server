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

ActiveRecord::Schema[7.2].define(version: 2024_06_27_185702) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alternate_artist_names", force: :cascade do |t|
    t.string "alt_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id"
    t.index ["artist_id"], name: "index_alternate_artist_names_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_songs", id: false, force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "song_id", null: false
  end

  create_table "song_download_queues", force: :cascade do |t|
    t.string "playlist_item_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_item_id"], name: "index_song_download_queues_on_playlist_item_id", unique: true
  end

  create_table "songs", force: :cascade do |t|
    t.string "original_title"
    t.string "title"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alternate_artist_names", "artists"
end
