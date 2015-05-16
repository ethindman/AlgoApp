ActiveRecord::Schema.define(version: 20150505004753) do

  create_table "favorites", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["post_id"], name: "index_favorites_on_post_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "followships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "followships", ["follower_id"], name: "index_followships_on_follower_id"
  add_index "followships", ["user_id"], name: "index_followships_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "code"
    t.text     "description"
    t.integer  "difficulty"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "rating"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "hash_key"
    t.string   "gravatar"
    t.string   "belts"
    t.text     "summary"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
