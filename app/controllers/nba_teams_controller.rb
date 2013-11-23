class NbaTeamsController < ApplicationController

  def standings
    @teams = NbaTeam.all

    query = ""
    query += "SELECT nba_team_id, "
    query += "COUNT(case when result = 'win' then 1 else null end) as wins, "
    query += "COUNT(case when result = 'loss' then 1 else null end) as losses, "
    query += "COUNT(*) as games_played, "
    query += "COUNT(case when result = 'win' and location = 'home' then 1 else null end) as home_wins, "
    query += "COUNT(case when result = 'loss' and location = 'home' then 1 else null end) as home_losses, "
    query += "COUNT(case when result = 'win' and location = 'away' then 1 else null end) as away_wins, "
    query += "COUNT(case when result = 'loss' and location = 'away' then 1 else null end) as away_losses "
    query += "FROM team_box_scores "
    query += "GROUP BY nba_team_id"

    results = ActiveRecord::Base.connection.execute(query)
    @standings = results.to_a

  end

  def index
    # pace
    # offensive rating
    # defensive rating
    # net rating
    # points per game
    # assists per game
    # assist percentage
    # offensive rebounds per game
    # defensive rebounds per game
    # total rebounds per game
    # total rebound percentage
    # steals per game
    # blocks per game
    # turnovers per game
    # turnovers forced per game
    # field goals attempted per game
    # field goals made per game
    # field goal percentage
    # 3pt attempted per game
    # 3pt made per game
    # 3pt percentage
    # free throw attempts per game
    # free throws made per game
    # free throw percentage

    # make a series of queries to get this data, then cache the model object, and make it expire every day

    respond_to do |format|
      format.html
      format.json { render json: generate_teams_query_json }
    end

  end

  def show
    @team = NbaTeam.find_by_abbr(params[:abbr].downcase)

    respond_to do |format|
      format.html
      format.json { render json: @team }
    end

  end

# CONFIGURATION
  def default_serializer_options
    { root: false }
  end

# JSON GENERATION
  def generate_teams_query_json
    Rails.cache.fetch "nba_teams_query_json", expires_in: 10.seconds do

      teams_query_data = []

      NbaTeam.all.each do |team|
        team_query_data = {}

        team_query_data["team_name"] = team.display_name
        team_query_data["games_played"] = team.games_played
        team_query_data["wins"] = team.won_games.count
        team_query_data["losses"] = team.lost_games.count
        team_query_data["home_wins"] = team.home_games.won_games.count
        team_query_data["home_losses"] = team.away_games.lost_games.count
        team_query_data["away_wins"] = team.away_games.won_games.count
        team_query_data["away_losses"] = team.away_games.lost_games.count
        team_query_data["winning_percentage"] = team.winning_percentage
        team_query_data["last_10_wins"] = team.recent_games(10).select { |bx| bx.result == "win" }.count
        team_query_data["last_10_losses"] = team.recent_games(10).select { |bx| bx.result == "loss" }.count
        team_query_data["pace"] = team.pace

        teams_query_data << team_query_data
      end

      teams_query_data

    end
  end

end
