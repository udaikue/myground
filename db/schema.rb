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

ActiveRecord::Schema.define(version: 2021_10_22_050731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diaries", force: :cascade do |t|
    t.boolean "open", default: false, null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.date "date", null: false
    t.string "ballpark", null: false
    t.string "team_home", null: false
    t.string "team_visitor", null: false
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
  end

  create_table "teams", force: :cascade do |t|
    t.integer "league_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
