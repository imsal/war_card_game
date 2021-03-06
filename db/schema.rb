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

ActiveRecord::Schema.define(version: 20170807221325) do

  create_table "games", force: :cascade do |t|
    t.string "session_id"
    t.string "user_1_deck"
    t.string "user_2_deck"
    t.string "user_name"
    t.integer "move"
    t.integer "user_1_cards_left"
    t.integer "user_2_cards_left"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "currently_in_war"
  end

end
