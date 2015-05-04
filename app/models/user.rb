class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites

	attr_accessor :password, :password_confirmation
	
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	
	validates :first_name, :last_name, presence: true, length: { in: 2..30 }
	
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	
	validates :password, presence: true, on: create, confirmation: true, length: { in: 8..100 }

	before_create :encrypt_password

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	private
		def encrypt_password
			self.hash_key = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?
			self.encrypted_password = encrypt(self.password)
		end

		def encrypt(pass)
			Digest::SHA2.hexdigest("#{self.hash_key}--#{pass}")
		end
end
