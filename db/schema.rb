# If you need to create the application database on another system, you should be using db:schema:load, not running all the migrations  from scratch. The latter is a flawed and unsustainable approach (the more migrations you'll amass, the slower it'll run and the greater likelihood for issues.

ActiveRecord::Schema.define(version: 20150501210016) do

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "code"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.integer  "difficulty"
    t.string   "category"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "hash_key"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "gravatar"
  end

end
