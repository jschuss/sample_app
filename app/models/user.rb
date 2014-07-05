class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  validates :name,  presence: true,
                    length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\b[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\b/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX,
                              message: "must be of the format \"x@y.z\"" }
  validates :password, length: { minimum: 6 }
  has_secure_password
end
