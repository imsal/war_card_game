class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :session_id
      t.string :deck_1
      t.string :deck_2
      t.string :user_name
      t.integer :move
      t.integer :user_1_points
      t.integer :user_2_points

      t.timestamps
    end
  end
end
