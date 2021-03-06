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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130419001542) do

  create_table "design_images", :force => true do |t|
    t.string  "name"
    t.string  "content_type"
    t.binary  "data",         :limit => 1048576
    t.integer "user_id"
  end

  create_table "favorites", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "tweet_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stats", :force => true do |t|
    t.string   "ip"
    t.string   "os"
    t.string   "browser"
    t.string   "from"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "session_id"
  end

  create_table "tweets", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "user_id",       :default => 1, :null => false
    t.integer  "retweet_id"
    t.integer  "retweet_count", :default => 0
    t.string   "link"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "description"
    t.boolean  "admin"
    t.text     "address"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.string   "profile_image"
  end

  create_table "users_have_followings", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "following_id"
  end

  add_index "users_have_followings", ["user_id", "following_id"], :name => "by_user_and_following", :unique => true

end
