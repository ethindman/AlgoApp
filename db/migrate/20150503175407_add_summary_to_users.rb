class AddSummaryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :summary, :text
    add_column :users, :belts, :string
    add_column :users, :favorite_posts, :string
  end
end
