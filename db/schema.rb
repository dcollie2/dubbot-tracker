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

ActiveRecord::Schema[7.0].define(version: 2022_10_25_011008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "scans", force: :cascade do |t|
    t.integer "pages"
    t.integer "overall_score"
    t.integer "broken_links"
    t.integer "accessibility_issues"
    t.integer "misspellings"
    t.integer "flagged_words"
    t.datetime "last_crawled_on"
    t.integer "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "batch_number"
    t.integer "size_group"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "system_id"
    t.string "dubbot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
