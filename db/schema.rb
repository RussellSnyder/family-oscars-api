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

ActiveRecord::Schema.define(version: 2019_12_28_195241) do

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "created_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "nominations", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "created_by"
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_nominations_on_category_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "created_by"
    t.integer "nomination_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nomination_id"], name: "index_votes_on_nomination_id"
  end

  add_foreign_key "nominations", "categories"
  add_foreign_key "votes", "nominations"
end
