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

ActiveRecord::Schema.define(version: 20170417014548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.boolean  "admin",      default: false
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

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
    t.datetime "starts_at",   null: false
    t.integer  "duration"
    t.integer  "location_id"
    t.string   "cover_image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_events_on_location_id", using: :btree
  end

  create_table "initiative_translations", force: :cascade do |t|
    t.integer  "initiative_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
    t.text     "description"
    t.index ["initiative_id"], name: "index_initiative_translations_on_initiative_id", using: :btree
    t.index ["locale"], name: "index_initiative_translations_on_locale", using: :btree
  end

  create_table "initiatives", force: :cascade do |t|
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.text     "directions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_profile_translations", force: :cascade do |t|
    t.integer  "member_profile_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "position"
    t.text     "bio"
    t.index ["locale"], name: "index_member_profile_translations_on_locale", using: :btree
    t.index ["member_profile_id"], name: "index_member_profile_translations_on_member_profile_id", using: :btree
  end

  create_table "member_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
    t.index ["team_id"], name: "index_member_profiles_on_team_id", using: :btree
    t.index ["user_id"], name: "index_member_profiles_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "logo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "partnership_translations", force: :cascade do |t|
    t.integer  "partnership_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.text     "description"
    t.index ["locale"], name: "index_partnership_translations_on_locale", using: :btree
    t.index ["partnership_id"], name: "index_partnership_translations_on_partnership_id", using: :btree
  end

  create_table "partnerships", force: :cascade do |t|
    t.string   "logo"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "relationship", default: "community_partner", null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "bio"
    t.string   "position"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_team_members_on_user_id", using: :btree
  end

  create_table "team_translations", force: :cascade do |t|
    t.integer  "team_id",     null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
    t.index ["locale"], name: "index_team_translations_on_locale", using: :btree
    t.index ["team_id"], name: "index_team_translations_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "events", "locations"
  add_foreign_key "member_profiles", "teams"
  add_foreign_key "member_profiles", "users"
end
