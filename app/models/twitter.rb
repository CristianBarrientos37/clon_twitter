class Twitter < ApplicationRecord
  include PgSearch::Model 
  
  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { maximum: 280 }
  
  # Improved search configuration
  pg_search_scope :search_full_text, 
    against: {
      username: 'A',
      description: 'B'
    },
    using: {
      tsearch: { prefix: true, any_word: true },
      trigram: { threshold: 0.3 }
    }
  
  # Scopes for better query organization
  scope :recent, -> { order(created_at: :desc) }
  scope :by_username, ->(username) { where(username: username) }
end
