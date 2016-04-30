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

ActiveRecord::Schema.define(version: 20160430072106) do

  create_table "companies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "site",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "company_id",  limit: 4
    t.string   "name",        limit: 255
    t.string   "uuid",        limit: 255
    t.date     "appear_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "job_id",      limit: 4
    t.boolean  "status"
    t.integer  "pay_low",     limit: 4
    t.integer  "pay_high",    limit: 4
    t.integer  "need_min",    limit: 4
    t.integer  "need_max",    limit: 4
    t.integer  "candidate",   limit: 4
    t.date     "record_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "description", limit: 65535
  end

  create_table "score_details", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.integer  "score",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "job_id",     limit: 4
    t.integer  "total",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
