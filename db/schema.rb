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

ActiveRecord::Schema[8.0].define(version: 2025_03_19_182849) do
  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.integer "num_teams"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "player_transfers", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.date "transfer_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_transfers_on_player_id"
    t.index ["team_id"], name: "index_player_transfers_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "position"
    t.string "nationality"
    t.integer "goals_scored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "league_id", null: false
    t.string "country"
    t.integer "founded_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  add_foreign_key "player_transfers", "players"
  add_foreign_key "player_transfers", "teams"
  add_foreign_key "teams", "leagues"
end
