class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_confirmation_of :password
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  has_many :reviews, dependent: :destroy

  before_validation -> { self.email = email.strip.downcase if email }

  def self.authenticate_with_credentials(email, password)
    user = find_by(email: email)&.authenticate(password)
    user ? user : nil
  end
end
