class TeamBoxScore < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  belongs_to :nba_matchup

# SCOPES
  scope :ordered_box_scores_for_team, ->(abbr) {
    joins(:nba_matchup).where(nba_team: NbaTeam.find_by_abbr(abbr)).order("gamedate DESC")
  }

# CONVENIENCE METHODS
  def team
    self.nba_team
  end

# QUERY METHODS
  def opponent
    return NbaMatchup.find(nba_matchup_id).away_team if location == "home"
    return NbaMatchup.find(nba_matchup_id).home_team if location == "away"
  end

  def opponent_box_score
    return TeamBoxScore.where(nba_matchup: nba_matchup, location: "away").first if location == "home"
    return TeamBoxScore.where(nba_matchup: nba_matchup, location: "home").first if location == "away"
  end

# DECORATORS
  def display_name
    "#{result} #{display_location} #{opponent.display_name} : #{gamedate}"
  end

  def display_location
    return "vs" if location == "home"
    return "at" if location == "away"
  end

# DELEGATIONS
  def gamedate
    nba_matchup.gamedate
  end

end
