class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :comment, :post_id, :user_id, presence: true
  validates_length_of :comment, minimum: 2

  validates_numericality_of :rating, presence: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5

end
