class GamesController < ApplicationController
  include Deck
  before_action :set_game, only: [:show, :edit, :update, :destroy, :evaluate]

  # before_action :check_correct_user_from_session, only: [:show]

  # pulls session_id from session to restore last game

=begin
  def load_game_from_session_id
    if session[:latest_game_token]
      redirect_to Game.find_by_session_id(session[:latest_game_token])
    else
      flash[:notice] = "We could not find a past session game. Please create a new game."
      redirect_to root_url
    end
  end
=end

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  # The User will specify their user_name here.
  def new
    @game = Game.new
  end


  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    @game.user_1_deck, @game.user_2_deck = create_values_and_split

    # count number of cards for newly created deck just for consistency
    @game.user_1_cards_left = count_number_of_cards_left(@game.user_1_deck)
    @game.user_2_cards_left = count_number_of_cards_left(@game.user_2_deck)


    respond_to do |format|
      if @game.save
        session[:latest_game_token] = @game.session_id
        format.html { redirect_to @game, notice: 'Welcome to the Game of War! Press the "DEAL" button below to start.' } # ,
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /games/1/edit
  def edit

  end

  def evaluate

    user_1_deck = @game.user_1_deck.split(',').map(&:to_i)
    user_2_deck = @game.user_2_deck.split(',').map(&:to_i)



    card_pot_to_win = {
      user_1_top_cards: Array.new , #['2','3', '4']
      user_2_top_cards: Array.new #['5','6', '7']
    }


    card_pot_to_win[:user_1_top_cards].push(user_1_deck.shift)
    card_pot_to_win[:user_2_top_cards].push(user_2_deck.shift)

    if card_pot_to_win[:user_1_top_cards][0] % 13 > card_pot_to_win[:user_2_top_cards][0] % 13

      # user 1 gains cards
      # @game.currently_in_war = false
      flash[:notice] = "#{card_image_name(card_pot_to_win[:user_1_top_cards][0]).gsub('_', ' ')} beats #{card_image_name(card_pot_to_win[:user_2_top_cards][0]).gsub('_', ' ')}. #{@game.user_name} wins the round!"


      user_1_deck.push(card_pot_to_win[:user_1_top_cards][0], card_pot_to_win[:user_2_top_cards][0])
      @game.user_1_deck = user_1_deck.join(', ') #.map(&:to_s)
      @game.user_2_deck = user_2_deck.join(', ') #.map(&:to_s)


    elsif card_pot_to_win[:user_2_top_cards][0] % 13 > card_pot_to_win[:user_1_top_cards][0] % 13
      # user 2 gains cards
      # @game.currently_in_war = false
      flash[:notice] = "#{card_image_name(card_pot_to_win[:user_2_top_cards][0]).gsub('_', ' ')} beats #{card_image_name(card_pot_to_win[:user_1_top_cards][0]).gsub('_', ' ')}. Computer wins the round!"

      user_2_deck.push(card_pot_to_win[:user_1_top_cards][0], card_pot_to_win[:user_2_top_cards][0])
      @game.user_2_deck = user_2_deck.join(', ') #.map(&:to_s)
      @game.user_1_deck = user_1_deck.join(', ') #.map(&:to_s))
    elsif card_pot_to_win[:user_1_top_cards][0] % 13 == card_pot_to_win[:user_2_top_cards][0] % 13
      # war
      # @game.currently_in_war = true
      flash[:notice] = "Both players draw a #{card_pot_to_win[:user_1_top_cards][0]}. This means WAR!"


    end



    @game.user_1_cards_left = count_number_of_cards_left(@game.user_1_deck)
    @game.user_2_cards_left = count_number_of_cards_left(@game.user_2_deck)

  end


  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game } # , notice: 'Game was successfully updated.'
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /games/1
  # # DELETE /games/1.json
  # def destroy
  #   @game.destroy
  #   respond_to do |format|
  #     format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:session_id, :user_name, :user_1_cards_left, :user_2_cards_left, :user_1_deck, :user_2_deck, :currently_in_war)
    end



    # check that correct user is playing and redirects if otherwise
=begin
    def check_correct_user_from_session
      if session[:latest_game_token] != @game.session_id
        # redirect_to root_url
        redirect_to load_path
        flash[:notice] = 'This is not your game! Redirected to last played game.'
      end
    end
=end

end
