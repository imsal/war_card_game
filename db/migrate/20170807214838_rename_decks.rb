class RenameDecks < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :deck_1, :user_1_deck
    rename_column :games, :deck_2, :user_2_deck
  end
end
