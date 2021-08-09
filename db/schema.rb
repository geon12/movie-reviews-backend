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

ActiveRecord::Schema.define(version: 2021_08_09_003331) do

  create_table "movie_reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "review"
    t.integer "likes"
    t.integer "movie_id"
    t.integer "reviewer_id"
    t.index ["movie_id"], name: "index_movie_reviews_on_movie_id"
    t.index ["reviewer_id"], name: "index_movie_reviews_on_reviewer_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "year"
    t.string "director"
    t.integer "duration"
  end

  create_table "reviewers", force: :cascade do |t|
    t.string "name"
    t.string "outlet"
  end

end
