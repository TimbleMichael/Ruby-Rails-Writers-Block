class User < ApplicationRecord
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 3, maximum: 25}
    validates :email, presence: true, uniqueness: true
    has_many :questions 
    has_secure_password
    before_save { self.email = email.downcase }
    
end
