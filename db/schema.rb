ActiveRecord::Schema.define(version: 2021_10_14_114631) do

  enable_extension "plpgsql"

  create_table "diaries", force: :cascade do |t|
    t.boolean "open", default: false, null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
