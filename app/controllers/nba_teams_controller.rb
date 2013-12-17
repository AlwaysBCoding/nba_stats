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
    # offensive rebounds per game
    # defensive rebounds per game
    # total rebounds per game
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
    File.read("#{Rails.root}/documents/teams.json")
  end
end
