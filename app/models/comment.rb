class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :comment, :post_id, :user_id, presence: true
  validates_length_of :comment, minimum: 2

end
