class NbaTeam < ActiveRecord::Base

# ASSOCIATIONS
  has_many :nba_players
  has_many :home_matchups, class_name: "NbaMatchup", foreign_key: "home_team_id"
  has_many :away_matchups, class_name: "NbaMatchup", foreign_key: "away_team_id"
  has_many :team_box_scores
  has_many :player_box_scores

# CONVENIENCE METHODS
  def nba_matchups
    home_matchups + away_matchups
  end

  def roster
    nba_players
  end

# QUERY METHODS
  def missing_team_box_scores
    nba_matchups - team_box_scores.map(&:nba_matchup)
  end

  def box_scores_from_matchup(matchup)
    PlayerBoxScore.where(nba_team_id: self.id, nba_matchup_id: matchup.id)
  end

  # This query is really inefficient because it's loading every single player_box_score into memory to find the ones that haven't been added
  # there is a much better way to do this with SQL instead of lading all the records into memory, i just dont know the arel for it
  def missing_player_box_scores
    nba_matchups - player_box_scores.map(&:nba_matchup)
  end

end
