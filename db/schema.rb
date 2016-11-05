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

ActiveRecord::Schema.define(version: 20161105200549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "name"
    t.inet     "remote_ip"
    t.integer  "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "start_at",    null: false
    t.integer  "duration"
    t.integer  "location_id"
    t.string   "cover_image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_events_on_location_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.text     "directions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.string   "logo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "events", "locations"
end
