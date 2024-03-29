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

ActiveRecord::Schema.define(version: 20150912110626) do

  create_table "retailers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_counts"
  end

  create_table "tweets", force: true do |t|
    t.integer  "tweet_id"
    t.string   "user_name"
    t.integer  "retweet_count"
    t.integer  "followers_count"
    t.integer  "friends_count"
    t.integer  "favorite_count"
    t.datetime "tweet_time"
    t.text     "text"
    t.string   "user_location"
    t.integer  "retailer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["retailer_id"], name: "index_tweets_on_retailer_id"

end
