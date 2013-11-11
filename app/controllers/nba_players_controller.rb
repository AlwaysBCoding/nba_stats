class NbaPlayersController < ApplicationController

  def show
    @player = NbaPlayer.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @player }
    end
  end

  def index
    @players = NbaPlayer.includes(:nba_team).all

    query = ""
    query += "SELECT nba_player_id, "
    query += "( sum(points)::float / COUNT(*) ) as points_per_game, "
    query += "( sum(assists)::float / COUNT(*) ) as assists_per_game, "
    query += "( sum(seconds_played)::float / COUNT(*) / 60 ) as minutes_per_game, "
    query += "( sum(offensive_rebounds)::float / COUNT(*) ) as offensive_rebounds_per_game, "
    query += "( sum(defensive_rebounds)::float / COUNT(*) ) as defensive_rebounds_per_game, "
    query += "( sum(offensive_rebounds)::float / COUNT(*) ) + ( sum(defensive_rebounds)::float / COUNT(*) ) as total_rebounds_per_game, "
    query += "( sum(steals)::float / COUNT(*) ) as steals_per_game, "
    query += "( sum(blocks)::float / COUNT(*) ) as blocks_per_game, "
    query += "( sum(turnovers)::float / COUNT(*) ) as turnovers_per_game, "
    query += "( sum(personal_fouls)::float / COUNT(*) ) as personal_fouls_per_game "
    query += "FROM player_box_scores "
    query += "GROUP BY nba_player_id "
    query += "ORDER BY points_per_game DESC;"

    results = ActiveRecord::Base.connection.execute(query)
    @stats = results.to_a

  end

# CONFIGURATION
  def default_serializer_options
    { root: false }
  end

end
