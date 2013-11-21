class NbaPlayersController < ApplicationController

  def show
    @player = NbaPlayer.find(params[:id])
    # @tweets = Twitter.user_timeline(@player.twitter, count: 10) if @player.twitter

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
    # query += "LIMIT 50;"

    results = ActiveRecord::Base.connection.execute(query).to_a

    player_names = results.map do |result|
      player = NbaPlayer.includes(:nba_team).find(result["nba_player_id"])
      result["display_name"] = player.display_name
      result["team"] = player.team.abbr
      result["position"] = player.position
      result["height"] = player.height
      result["college"] = player.college
    end

    respond_to do |format|
      format.html
      format.json { render json: results }
    end

  end

# CONFIGURATION
  def default_serializer_options
    { root: false }
  end

end
