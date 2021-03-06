class User < ActiveRecord::Base
  has_many :parcels, dependent: :destroy

  before_save { email.downcase! unless email.nil? }
  before_save { name.capitalize! unless name.nil? }

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }
end
