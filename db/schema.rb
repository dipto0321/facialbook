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

ActiveRecord::Schema.define(version: 2019_06_19_065128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "commentable_type"
    t.text "body"
    t.string "comment_pic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "author_id"
    t.uuid "commentable_id"
  end

  create_table "friend_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "concatenated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "requester_id"
    t.uuid "requestee_id"
    t.index ["concatenated"], name: "index_friend_requests_on_concatenated", unique: true
  end

  create_table "friendships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "concatenated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.uuid "friend_id"
    t.index ["concatenated"], name: "index_friendships_on_concatenated", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.string "likeable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "liker_id"
    t.uuid "likeable_id"
  end

  create_table "posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "body"
    t.string "post_pic"
    t.string "postable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "author_id"
    t.uuid "postable_id"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthday"
    t.text "bio"
    t.string "gender"
    t.string "profile_picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "middle_name"
    t.uuid "user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "users", column: "author_id", name: "comments_author_id_fkey"
  add_foreign_key "friend_requests", "users", column: "requestee_id", name: "friend_requests_requestee_id_fkey"
  add_foreign_key "friend_requests", "users", column: "requester_id", name: "friend_requests_requester_id_fkey"
  add_foreign_key "friendships", "users", column: "friend_id", name: "friendships_friend_id_fkey"
  add_foreign_key "friendships", "users", name: "friendships_user_id_fkey"
  add_foreign_key "likes", "users", column: "liker_id", name: "likes_liker_id_fkey"
  add_foreign_key "posts", "users", column: "author_id", name: "posts_author_id_fkey"
  add_foreign_key "profiles", "users", name: "profiles_user_id_fkey"
end
