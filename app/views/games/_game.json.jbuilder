json.extract! game, :id, :session_id, :deck_1, :deck_2, :user_name, :move, :user_1_points, :user_2_points, :created_at, :updated_at
json.url game_url(game, format: :json)
