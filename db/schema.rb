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

ActiveRecord::Schema.define(version: 2020_01_16_092942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backgrounds", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_backgrounds_on_organization_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id", null: false
    t.string "icon"
    t.index ["organization_id"], name: "index_channels_on_organization_id"
  end

  create_table "channels_contents", id: false, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "content_id", null: false
    t.index ["channel_id", "content_id"], name: "index_channels_contents_on_channel_id_and_content_id"
    t.index ["content_id", "channel_id"], name: "index_channels_contents_on_content_id_and_channel_id"
  end

  create_table "channels_device_groups", id: false, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "device_group_id", null: false
    t.index ["channel_id", "device_group_id"], name: "index_channels_device_groups_on_channel_id_and_device_group_id"
    t.index ["device_group_id", "channel_id"], name: "index_channels_device_groups_on_device_group_id_and_channel_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "contents", force: :cascade do |t|
    t.string "type"
    t.string "video_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.string "title"
    t.text "body"
    t.string "file"
    t.text "presentation_body_plain"
    t.index ["organization_id"], name: "index_contents_on_organization_id"
  end

  create_table "device_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id", null: false
    t.text "description"
    t.index ["name"], name: "index_device_groups_on_name"
    t.index ["organization_id"], name: "index_device_groups_on_organization_id"
  end

  create_table "device_groups_devices", id: false, force: :cascade do |t|
    t.bigint "device_group_id", null: false
    t.bigint "device_id", null: false
    t.index ["device_group_id", "device_id"], name: "index_device_groups_devices_on_device_group_id_and_device_id"
    t.index ["device_id", "device_group_id"], name: "index_device_groups_devices_on_device_id_and_device_group_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.boolean "active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_devices_on_organization_id"
    t.index ["token"], name: "index_devices_on_token"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_feedbacks_on_deleted_at"
  end

  create_table "gallery_images", force: :cascade do |t|
    t.bigint "gallery_id"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gallery_id"], name: "index_gallery_images_on_gallery_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.integer "organization_id"
    t.string "role"
    t.integer "sender_id"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_invites_on_organization_id"
    t.index ["token"], name: "index_invites_on_token"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "read", default: false
    t.string "notificable_type"
    t.bigint "notificable_id"
    t.bigint "user_id"
    t.string "notification_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notificable_type", "notificable_id"], name: "index_notifications_on_notificable_type_and_notificable_id"
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
  end

  create_table "screenshots", force: :cascade do |t|
    t.integer "presentation_id"
    t.string "file"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["presentation_id"], name: "index_screenshots_on_presentation_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
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
    t.string "google_token"
    t.string "google_refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "backgrounds", "organizations"
  add_foreign_key "channels", "organizations"
  add_foreign_key "contents", "organizations"
  add_foreign_key "device_groups", "organizations"
  add_foreign_key "devices", "organizations"
  add_foreign_key "users", "organizations"
end
