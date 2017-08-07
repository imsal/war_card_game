class AddWarBooleanToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :currently_in_war, :boolean
  end
end
