class TeamBoxScore < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  belongs_to :nba_matchup

# SCOPES
  scope :recent, ->(n) {
    includes(:nba_matchup).joins(:nba_matchup).order("gamedate desc").limit(n)
  }

  scope :won_games, -> {
    where(result: "win")
  }

  scope :lost_games, -> {
    where(result: "loss")
  }

  scope :home_games, -> {
    where(location: "home")
  }

  scope :away_games, -> {
    where(location: "away")
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
