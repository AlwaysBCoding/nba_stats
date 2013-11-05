# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131105052152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nba_matchups", force: true do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.string   "basketball_reference_id"
    t.string   "referees",                default: [], array: true
    t.date     "gamedate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nba_players", force: true do |t|
    t.integer  "nba_team_id"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "display_name"
    t.integer  "number"
    t.string   "position"
    t.integer  "height"
    t.integer  "weight"
    t.date     "birthdate"
    t.integer  "experience"
    t.string   "college"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nba_teams", force: true do |t|
    t.string   "city"
    t.string   "name"
    t.string   "abbr"
    t.string   "conference"
    t.string   "division"
    t.string   "nba_stats_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_box_scores", force: true do |t|
    t.integer  "nba_player_id"
    t.integer  "nba_matchup_id"
    t.string   "location"
    t.integer  "seconds"
    t.integer  "field_goals_made"
    t.integer  "field_goals_attempted"
    t.integer  "three_pointers_made"
    t.integer  "three_pointers_attempted"
    t.integer  "free_throws_made"
    t.integer  "free_throws_attempted"
    t.integer  "offensive_rebounds"
    t.integer  "defensive_rebounds"
    t.integer  "assists"
    t.integer  "steals"
    t.integer  "blocks"
    t.integer  "turnovers"
    t.integer  "personal_fouls"
    t.integer  "points"
    t.integer  "offensive_rating"
    t.integer  "defensive_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_box_scores", force: true do |t|
    t.integer  "nba_matchup_id"
    t.integer  "nba_team_id"
    t.string   "location"
    t.integer  "q1_pts"
    t.integer  "q2_pts"
    t.integer  "q3_pts"
    t.integer  "q4_pts"
    t.integer  "score"
    t.string   "result"
    t.integer  "pace"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
