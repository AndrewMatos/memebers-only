class User < ApplicationRecord
	attr_accessor :remem
    before_create  :create_activation_digest
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:name, :email, presence: true, length: {in: 6..50}, uniqueness: {case_sensitive: false})
    validates(:email, length:{in: 2..90}, format: {with: VALID_EMAIL_REGEX})
    validates(:password, presence: true, length: {minimum: 5})
    has_secure_password
    has_many :comments
    
    def self.digest(string)
       Digest::SHA1.hexdigest string
    end

    def self.new_token
      SecureRandom.urlsafe_base64
    end

    def remember
      self.remem = User.new_token 
      update_attribute(:remember_token , User.digest(remem))
    end

    def forget
      update_attribute(:remember_token, nil )
    end

    private

    def create_activation_digest
      self.remem = User.new_token 
      self.remember_token = User.digest(remem)
    end

end
