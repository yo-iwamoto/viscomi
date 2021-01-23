# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_15_052856) do

  create_table "ad_images", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ads", force: :cascade do |t|
    t.string "owner_name", null: false
    t.text "content"
    t.string "phone_number"
    t.string "url"
    t.integer "community_center_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_center_id"], name: "index_ads_on_community_center_id"
  end

  create_table "community_centers", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_community_centers_on_user_id"
  end

  create_table "community_cetner_images", force: :cascade do |t|
    t.text "image"
    t.integer "community_center_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_center_id"], name: "index_community_cetner_images_on_community_center_id"
  end

  create_table "post_images", force: :cascade do |t|
    t.text "image"
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_images_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "type", default: "", null: false
    t.string "title"
    t.string "content"
    t.integer "community_center_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_center_id"], name: "index_posts_on_community_center_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_subscriptions_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_subscriptions_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_subscriptions_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "activated", default: false
    t.string "activation_digest"
    t.boolean "is_manager", default: false
    t.string "authentication_digest"
  end

  add_foreign_key "ads", "community_centers"
  add_foreign_key "community_centers", "users"
  add_foreign_key "community_cetner_images", "community_centers"
  add_foreign_key "post_images", "posts"
  add_foreign_key "posts", "community_centers"
end
