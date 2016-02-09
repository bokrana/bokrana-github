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

ActiveRecord::Schema.define(version: 20151027115756) do

  create_table "mail_lists", force: :cascade do |t|
    t.string   "email",      limit: 60,                null: false
    t.boolean  "active",     limit: 1,  default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "mail_lists", ["email"], name: "index_mail_lists_on_email", unique: true, using: :btree

  create_table "passion_passionates", force: :cascade do |t|
    t.integer  "passion_id",    limit: 4
    t.integer  "passionate_id", limit: 4
    t.integer  "price_from",    limit: 8,     default: 0
    t.integer  "price_to",      limit: 8,     default: 0
    t.integer  "discount",      limit: 4,     default: 0
    t.text     "note",          limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "passion_passionates", ["passion_id", "passionate_id"], name: "index_passion_passionates_on_passion_id_and_passionate_id", unique: true, using: :btree

  create_table "passionates", force: :cascade do |t|
    t.string   "email",                      limit: 60,                         null: false
    t.string   "hashed_password",            limit: 255
    t.string   "salt_password",              limit: 255
    t.string   "name",                       limit: 255,                        null: false
    t.text     "description",                limit: 65535
    t.string   "phone",                      limit: 20
    t.string   "website",                    limit: 255
    t.string   "facebook_page",              limit: 255
    t.string   "facebook_personal_profile",  limit: 255
    t.string   "twitter",                    limit: 255
    t.string   "skype",                      limit: 255
    t.string   "youtube",                    limit: 255
    t.boolean  "lock",                       limit: 1,     default: false
    t.boolean  "activate",                   limit: 1,     default: false
    t.string   "activate_url",               limit: 255
    t.integer  "recommend_num",              limit: 4,     default: 0
    t.integer  "views_num",                  limit: 4,     default: 0
    t.string   "slug",                       limit: 255
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "profile_image_file_name",    limit: 255
    t.string   "profile_image_content_type", limit: 255
    t.integer  "profile_image_file_size",    limit: 4
    t.datetime "profile_image_updated_at"
    t.string   "role",                       limit: 12,    default: "standard"
  end

  add_index "passionates", ["email"], name: "index_passionates_on_email", unique: true, using: :btree
  add_index "passionates", ["slug"], name: "index_passionates_on_slug", using: :btree

  create_table "passions", force: :cascade do |t|
    t.string   "name",                       limit: 120,                  null: false
    t.text     "description",                limit: 65535
    t.integer  "passionates_num",            limit: 8,     default: 0
    t.boolean  "visible",                    limit: 1,     default: true
    t.string   "slug",                       limit: 255
    t.string   "created_by",                 limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "passion_image_file_name",    limit: 255
    t.string   "passion_image_content_type", limit: 255
    t.integer  "passion_image_file_size",    limit: 4
    t.datetime "passion_image_updated_at"
    t.string   "category",                   limit: 255
    t.integer  "view_num",                   limit: 4,     default: 0
  end

  add_index "passions", ["name"], name: "index_passions_on_name", unique: true, using: :btree
  add_index "passions", ["slug"], name: "index_passions_on_slug", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "passionate_id", limit: 4
    t.string   "path",          limit: 255
    t.text     "description",   limit: 65535
    t.boolean  "visible",       limit: 1,     default: true
    t.boolean  "profile_photo", limit: 1,     default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "photos", ["passionate_id"], name: "index_photos_on_passionate_id", using: :btree

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id",       limit: 4
    t.string  "foreign_key_name", limit: 255, null: false
    t.integer "foreign_key_id",   limit: 4
  end

  add_index "version_associations", ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
  add_index "version_associations", ["version_id"], name: "index_version_associations_on_version_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255,        null: false
    t.integer  "item_id",        limit: 4,          null: false
    t.string   "event",          limit: 255,        null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object",         limit: 4294967295
    t.datetime "created_at"
    t.text     "object_changes", limit: 4294967295
    t.integer  "transaction_id", limit: 4
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "passionate_id", limit: 4
    t.string   "path",          limit: 255
    t.text     "description",   limit: 65535
    t.boolean  "visible",       limit: 1,     default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "videos", ["passionate_id"], name: "index_videos_on_passionate_id", using: :btree

end
