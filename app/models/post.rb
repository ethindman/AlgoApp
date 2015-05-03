class Post < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :description, :code, :user_id, presence: true
  
  validates_length_of :title, :description, minimum: 2

  validates :category, inclusion: { in: %w(Array Sort Recursion LinkedList BinaryTree Divide&Conquer Fibonacci Greedy Branch&Bound BruteForce Randomized Backtracking Other),
    message: "%{value} is not valid" }

end
