class AddIndexesToTwitters < ActiveRecord::Migration[7.2]
  def change
    # Add index for username searches and uniqueness constraint
    add_index :twitters, :username, unique: true
    
    # Add index for created_at ordering (most common query)
    add_index :twitters, :created_at
    
    # Add index for full-text search on description
    add_index :twitters, :description, using: :gin, opclass: :gin_trgm_ops
    
    # Enable pg_trgm extension for trigram searches
    enable_extension "pg_trgm"
  end
end