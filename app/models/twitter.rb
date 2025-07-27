class Twitter < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations - Remover username ya que ahora viene del usuario
  validates :description, presence: true, length: { maximum: 280 }
  
  # Scopes for better query organization
  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user) { where(user: user) }
  scope :public_tweets, -> { joins(:user).includes(:user) }
  
  # Simple search method for SQLite
  def self.search_full_text(query)
    return all if query.blank?
    
    joins(:user).where(
      "description LIKE ? OR users.username LIKE ? OR users.first_name LIKE ? OR users.last_name LIKE ?", 
      "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
    )
  end

  # Instance methods
  def author_name
    user.full_name
  end

  def author_username
    user.display_name
  end

  def time_ago
    time_diff = Time.current - created_at
    
    case time_diff
    when 0..59
      "#{time_diff.to_i}s"
    when 60..3599
      "#{(time_diff / 60).to_i}m"
    when 3600..86399
      "#{(time_diff / 3600).to_i}h"
    else
      "#{(time_diff / 86400).to_i}d"
    end
  end
end
