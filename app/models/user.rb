class User < ActiveRecord::Base
  has_one :api_key, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :books, through: :reviews

  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email
  before_create :create_api_key, :create_activation_digest

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: {case_sensitive: false}, length: {maximum: 255}

  # Creates password and password confirmation with validations
  has_secure_password
  validates :password, length: {minimum: 6}

  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forget a user in the cookie
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Send an email to activate the account
  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  # Sets the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def self.find_by_access_token(access_token)
    APIKey.find_by(access_token: access_token).user
  end

  private

    def downcase_email
      self.email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def create_api_key
      self.api_key = APIKey.create
    end

end
