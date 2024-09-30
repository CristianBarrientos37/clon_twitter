class Twitter < ApplicationRecord
  include PgSearch::Model 
  
  pg_search_scope :search_full_text, 
  against: {
    username: 'A',
    id: 'B'
  }
end
