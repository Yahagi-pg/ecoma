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

ActiveRecord::Schema.define(version: 20150310103608) do

  create_table "categories", force: true do |t|
    t.string   "category"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posters", force: true do |t|
    t.string   "title"
    t.string   "contributor"
    t.datetime "posted"
    t.string   "content"
    t.string   "delete_key"
    t.boolean  "closed"
    t.integer  "server_id"
    t.integer  "category_id"
    t.string   "mac_address"
    t.string   "ip_address"
    t.string   "notification_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: true do |t|
    t.integer  "poster_id"
    t.string   "contributor"
    t.datetime "posted"
    t.string   "content"
    t.string   "mac_address"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", force: true do |t|
    t.string   "server"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
