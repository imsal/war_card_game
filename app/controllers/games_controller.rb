class GamesController < ApplicationController
  include Deck
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :check_correct_user_from_session, only: [:show]
  # before_action :load_game_from_session_id, only: [:show]

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

  # GET /games/1/edit
  def edit

    if user_1_top_card > user_2_top_card
      # user 1 gains cards
      # @game.currently_in_war = false
    elsif user_2_top_card > user_1_top_card
      # user 2 gains cards
      # @game.currently_in_war = false
    elsif user_1_top_card == user_2_top_card
      # war
      # @game.currently_in_war = true
    end

    redirect_to :update
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
        session[:id] = @game.session_id
        format.html { redirect_to @game, notice: 'Welcome to the Game of War! Press the "DEAL" button below to start.' } # ,
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
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
      params.require(:game).permit(:user_name) # :session_id, :move, :user_1_cards_left, :user_2_cards_left, :user_1_deck, :user_2_deck,
    end

    # pulls session_id from session to restore last game
    def load_game_from_session_id
    end

    # check that correct user is playing and redirects if otherwise
    def check_correct_user_from_session

      if session[:id] != @game.session_id
        # redirect_to root_url
        redirect_to Game.find_by_session_id(session[:id])
        flash[:notice] = 'This is not your game! Redirected to last played game.'
      end
    end

end
