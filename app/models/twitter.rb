class Twitter < ApplicationRecord
  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { maximum: 280 }
  
  # Scopes for better query organization
  scope :recent, -> { order(created_at: :desc) }
  scope :by_username, ->(username) { where(username: username) }
  
  # Simple search method for SQLite
  def self.search_full_text(query)
    return all if query.blank?
    
    where("username LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
  end
end
