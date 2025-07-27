class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :twitters, dependent: :destroy

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 25 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  # Callbacks
  before_save :format_username

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_username, ->(username) { where(username: username) }

  # Instance methods
  def full_name
    "#{first_name} #{last_name}".strip
  end

  def display_name
    "@#{username}"
  end

  def tweet_count
    twitters.count
  end

  private

  def format_username
    self.username = username.downcase.strip if username.present?
  end
end
