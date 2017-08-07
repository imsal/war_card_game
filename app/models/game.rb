class Game < ApplicationRecord

  before_save :create_session_id

  private

  def create_session_id
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    string = (0...50).map { o[rand(o.length)] }.join

    self.session_id = string
  end
  
end
