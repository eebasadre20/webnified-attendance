class Hero < ActiveRecord::Base
	has_many :attendances
	attr_accessor :password
	before_save :encrypt_password
	after_save	:clear_password

    EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	validates :firstname, :presence => true, :length => { :in => 3..20 }
	validates :lastname, :presence => true, :length => { :in => 3..20 }
	validates :company_position, :presence => true, :length => { :in => 3..20 }
	validates :gender, :presence => true
	validates :contact_number, :presence => true
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :presence => true
	validates_length_of :password, :in => 6..20, :on => :create

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password_digest = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		self.password = nil
	end

	def self.authenticate(username_or_email="", login_password="")
		if EMAIL_REGEX.match(username_or_email)
			hero = Hero.find_by_email(username_or_email)
		else
			hero = Hero.find_by_username(username_or_email)
		end

		if hero && hero.match_password(login_password)
			return hero
		else
			return false
		end
	end

	def match_password(login_password="")
		password_digest == BCrypt::Engine.hash_secret(login_password, salt)
	end

end
