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

ActiveRecord::Schema.define(version: 2022_03_27_105302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ballparks", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "available", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diaries", force: :cascade do |t|
    t.boolean "published", default: false, null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.index ["game_id"], name: "index_diaries_on_game_id"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.date "date", null: false
    t.integer "score_home", null: false
    t.integer "score_visitor", null: false
    t.integer "hits_home", null: false
    t.integer "hits_visitor", null: false
    t.integer "errors_home", null: false
    t.integer "errors_visitor", null: false
    t.string "winning_pitcher"
    t.string "losing_pitcher"
    t.string "saving_pitcher"
    t.string "homerun_home"
    t.string "homerun_visitor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ballpark_id", null: false
    t.bigint "team_home_id", null: false
    t.bigint "team_visitor_id", null: false
    t.index ["ballpark_id"], name: "index_games_on_ballpark_id"
    t.index ["team_home_id"], name: "index_games_on_team_home_id"
    t.index ["team_visitor_id"], name: "index_games_on_team_visitor_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title", null: false
    t.bigint "diary_id", null: false
    t.index ["diary_id"], name: "index_links_on_diary_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "inning", null: false
    t.string "home"
    t.string "visitor"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_scores_on_game_id"
  end

  create_table "scrapings", force: :cascade do |t|
    t.string "url", null: false
    t.date "game_date", null: false
    t.boolean "done", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer "league_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diaries", "games"
  add_foreign_key "diaries", "users"
  add_foreign_key "games", "ballparks"
  add_foreign_key "games", "teams", column: "team_home_id"
  add_foreign_key "games", "teams", column: "team_visitor_id"
  add_foreign_key "links", "diaries"
  add_foreign_key "scores", "games"
end
