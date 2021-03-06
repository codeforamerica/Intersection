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

ActiveRecord::Schema.define(:version => 20120709153546) do

  create_table "activities", :force => true do |t|
    t.integer   "team_id"
    t.integer   "user_id"
    t.integer   "project_id"
    t.text      "activity"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "batchbook_list_histories", :force => true do |t|
    t.integer   "batchbook_list_id"
    t.integer   "contact_number"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "batchbook_lists", :force => true do |t|
    t.integer   "team_id"
    t.integer   "batchbook_id"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.string    "locked_by"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.integer   "team_id"
    t.string    "name"
    t.integer   "attendance"
    t.timestamp "event_date"
    t.string    "url"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "link_types", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string    "name"
    t.integer   "project_id"
    t.integer   "link_type_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "url"
  end

  create_table "milestones", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer   "user_id"
    t.string    "name"
    t.text      "bio"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "user_type"
  end

  create_table "project_milestones", :force => true do |t|
    t.integer   "project_id"
    t.integer   "milestone_id"
    t.date      "planned_date"
    t.boolean   "active",         :default => false
    t.date      "completed_date"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "project_users", :force => true do |t|
    t.integer   "project_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.text      "impact_statement"
    t.boolean   "active",           :default => true
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "featured",         :default => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text      "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "stories", :force => true do |t|
    t.integer   "user_id"
    t.integer   "project_id"
    t.integer   "team_id"
    t.text      "story"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "survey_responses", :force => true do |t|
    t.integer   "survey_id"
    t.integer   "response"
    t.text      "note"
    t.integer   "user_id"
    t.date      "expires_on"
    t.string    "surveyable_type"
    t.integer   "surveyable_id"
    t.string    "code"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string    "name"
    t.string    "survey_type"
    t.integer   "scale"
    t.timestamp "start_date"
    t.timestamp "end_date"
    t.integer   "frequency"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context"
    t.timestamp "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "team_projects", :force => true do |t|
    t.integer   "project_id"
    t.integer   "team_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "team_users", :force => true do |t|
    t.integer   "user_id"
    t.integer   "team_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string    "name"
    t.boolean   "active",            :default => true
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "sort_order"
    t.string    "logo_file_name"
    t.string    "logo_content_type"
    t.integer   "logo_file_size"
    t.datetime  "logo_updated_at"
  end

  create_table "user_types", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
