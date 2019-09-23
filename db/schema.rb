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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2019_09_23_131248) do
=======
ActiveRecord::Schema.define(version: 2019_09_18_065150) do
>>>>>>> e3a2988a49fac5d4d870cb84da6dc913d2c45b68

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "details"
<<<<<<< HEAD
    t.string "state"
    t.string "priority"
    t.datetime "end_date"
    t.date "created_at", default: -> { "now()" }
=======
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.string "priority"
    t.datetime "end_date"
>>>>>>> e3a2988a49fac5d4d870cb84da6dc913d2c45b68
  end

end
