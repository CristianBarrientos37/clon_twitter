class AddIndexesToTwitters < ActiveRecord::Migration[7.2]
  def change
    # Add index for username searches and uniqueness constraint
    add_index :twitters, :username, unique: true
    
    # Add index for created_at ordering (most common query)
    add_index :twitters, :created_at
    
    # Add index for description searches (SQLite compatible)
    add_index :twitters, :description
  end
end