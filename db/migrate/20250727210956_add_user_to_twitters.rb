class AddUserToTwitters < ActiveRecord::Migration[7.2]
  def change
    add_reference :twitters, :user, null: false, foreign_key: true
  end
end
