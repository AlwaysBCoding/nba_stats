class NbaMatchupsController < ApplicationController

  def show
    @source_player = NbaPlayer.find(params[:source_player]) if params[:source_player].present?
    @source_team = NbaTeam.find(params[:source_team]) if params[:source_team].present?
    @matchup = NbaMatchup.find(params[:id])
    @away_team_box_score = TeamBoxScore.where(nba_matchup: @matchup, nba_team: @matchup.away_team).first
    @home_team_box_score = TeamBoxScore.where(nba_matchup: @matchup, nba_team: @matchup.home_team).first
    @away_team_player_box_scores = @matchup.player_box_scores.select { |bx| bx.location == "away" }
    @home_team_player_box_scores = @matchup.player_box_scores.select { |bx| bx.location == "home" }
  end

end
