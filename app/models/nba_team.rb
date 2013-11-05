class NbaTeam < ActiveRecord::Base

# ASSOCIATIONS
  has_many :nba_players
  has_many :home_matchups, class_name: "NbaMatchup", foreign_key: "home_team_id"
  has_many :away_matchups, class_name: "NbaMatchup", foreign_key: "away_team_id"
  has_many :team_box_scores

# CONVENIENCE METHODS
  def nba_matchups
    home_matchups + away_matchups
  end

  def roster
    nba_players
  end

# QUERY METHODS
  def missing_box_scores
    nba_matchups - team_box_scores.map(&:nba_matchup)
  end

end
