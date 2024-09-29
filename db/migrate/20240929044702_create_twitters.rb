class CreateTwitters < ActiveRecord::Migration[7.2]
  def change
    create_table :twitters do |t|
      t.string :description
      t.string :username

      t.timestamps
    end
  end
end
