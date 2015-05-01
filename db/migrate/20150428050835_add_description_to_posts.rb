class AddDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :string
    add_column :posts, :difficulty, :integer
    add_column :posts, :category, :string
    rename_column :posts, :content, :code
  end
end
