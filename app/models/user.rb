class User < ActiveRecord::Base
	validates :username, :email, :session_token, presence: true, uniqueness: true
	validates :pw_digest, presence: true, length: { minimum: 4, allow_nil: true }

	after_initialize :ensure_session_token

	def self.find_by_credentials(username, pw)
		user = User.find_by_username(username)
		return nil if user.nil?
		user.is_password?(pw) ? user : nil
	end

	def self.generate_session_token
		SecureRandom::urlsafe_base64
	end

	def password=(pw)
		@pw = pw
		# Must access pw_digest through self because it is an
		# ActiveRecord method. It otherwise seems to create
		# a local variable. Using @pw_digest doesn't work either
		self.pw_digest = BCrypt::Password.create(pw)
	end

	def is_password?(pw)
		BCrypt::Password.new(self.pw_digest).is_password?(pw)
	end

	def reset_session_token!
		self.session_token = User::generate_session_token
		self.save
	end	

	def ensure_session_token
		self.session_token ||= User::generate_session_token
	end
end
