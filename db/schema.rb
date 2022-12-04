# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_12_03_233103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notification_topics", force: :cascade do |t|
    t.bigint "notification_id"
    t.bigint "topic_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_id"], name: "index_notification_topics_on_notification_id"
    t.index ["topic_id"], name: "index_notification_topics_on_topic_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "date"
    t.boolean "status", default: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "subject_users", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_subject_users_on_subject_id"
    t.index ["user_id"], name: "index_subject_users_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.string "shift"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.integer "study_hours"
    t.boolean "status", default: false
    t.bigint "user_id"
    t.bigint "subject_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_topics_on_subject_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "course"
    t.integer "period"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "notification_topics", "notifications"
  add_foreign_key "notification_topics", "topics"
  add_foreign_key "notifications", "users"
  add_foreign_key "subject_users", "subjects"
  add_foreign_key "subject_users", "users"
  add_foreign_key "topics", "subjects"
  add_foreign_key "topics", "users"
end
