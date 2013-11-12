class NbaTeamsController < ApplicationController

  def index
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

end
