class RenamePointsToCardsLeft < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :user_1_points, :user_1_cards_left
    rename_column :games, :user_2_points, :user_2_cards_left
  end
end
