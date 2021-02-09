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

ActiveRecord::Schema.define(version: 2021_02_05_135622) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "ad_images", force: :cascade do |t|
    t.text "image"
    t.integer "ad_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ad_id"], name: "index_ad_images_on_ad_id"
  end

  create_table "ad_registries", force: :cascade do |t|
    t.integer "ad_id", null: false
    t.integer "community_center_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ad_id"], name: "index_ad_registries_on_ad_id"
    t.index ["community_center_id"], name: "index_ad_registries_on_community_center_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "ads", force: :cascade do |t|
    t.string "owner_name", null: false
    t.text "content"
    t.string "phone_number"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "community_centers", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_community_centers_on_user_id", unique: true
  end

  create_table "community_cetner_images", force: :cascade do |t|
    t.text "image"
    t.integer "community_center_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_center_id"], name: "index_community_cetner_images_on_community_center_id"
  end

  create_table "contact_images", force: :cascade do |t|
    t.text "image"
    t.integer "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_contact_images_on_contact_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "community_center_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.boolean "now_processing", default: false, null: false
    t.datetime "sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_center_id"], name: "index_contacts_on_community_center_id"
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
    t.integer "user_id", null: false
    t.integer "community_center_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["community_center_id"], name: "index_subscriptions_on_community_center_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.string "authentication_digest"
    t.boolean "activated", default: false, null: false
    t.boolean "mute_contact", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "ad_images", "ads"
  add_foreign_key "ad_registries", "ads"
  add_foreign_key "ad_registries", "community_centers"
  add_foreign_key "community_centers", "users"
  add_foreign_key "community_cetner_images", "community_centers"
  add_foreign_key "contact_images", "contacts"
  add_foreign_key "contacts", "community_centers"
  add_foreign_key "post_images", "posts"
  add_foreign_key "posts", "community_centers"
  add_foreign_key "subscriptions", "community_centers"
  add_foreign_key "subscriptions", "users"
end
