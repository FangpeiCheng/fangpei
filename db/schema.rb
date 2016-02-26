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

ActiveRecord::Schema.define(version: 20160219123556) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "micropost_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["micropost_id"], name: "index_comments_on_micropost_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "dreams", force: :cascade do |t|
    t.text     "name"
    t.text     "content"
    t.string   "date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dreams", ["user_id", "created_at"], name: "index_dreams_on_user_id_and_created_at"
  add_index "dreams", ["user_id"], name: "index_dreams_on_user_id"

  create_table "goals", force: :cascade do |t|
    t.text     "name"
    t.text     "content"
    t.string   "deadline"
    t.integer  "user_id"
    t.integer  "dream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "goals", ["dream_id"], name: "index_goals_on_dream_id"
  add_index "goals", ["user_id", "created_at"], name: "index_goals_on_user_id_and_created_at"
  add_index "goals", ["user_id"], name: "index_goals_on_user_id"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "picture"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "post_likes", force: :cascade do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "post_likes", ["micropost_id"], name: "index_post_likes_on_micropost_id"
  add_index "post_likes", ["user_id", "micropost_id", "created_at"], name: "index_post_likes_on_user_id_and_micropost_id_and_created_at"
  add_index "post_likes", ["user_id"], name: "index_post_likes_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "micropost_id"
    t.integer  "tag_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "taggings", ["micropost_id"], name: "index_taggings_on_micropost_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
