class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments
	
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	
	validates :first_name, :last_name, presence: true, length: { in: 2..20 }

	validates :encrypted_password, presence: true, length: { in: 8..20 }

	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

	before_save do
		self.email.downcase!
		self.first_name.capitalize!
		self.last_name.capitalize!
	end

end
