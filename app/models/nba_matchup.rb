class NbaMatchup < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :home_team, class_name: "NbaTeam", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "NbaTeam", foreign_key: "away_team_id"
  has_many :team_box_scores
  has_many :player_box_scores

# VALIDATIONS
  validates :basketball_reference_id, uniqueness: true

# SCOPES
  scope :matchups_for_team, ->(abbr) {
    where("home_team_id = ? OR away_team_id = ?", NbaTeam.find_by_abbr(abbr).id, NbaTeam.find_by_abbr(abbr).id)
  }

# DECORATORS
  def display_name
    "#{away_team.display_name} @ #{home_team.display_name} : #{gamedate.strftime('%b %d %Y')}"
  end

# QUERY METHODS
  def opponent(team)
    return NbaTeam.find(away_team_id) if team.id == home_team_id
    return NbaTeam.find(home_team_id) if team.id == away_team_id
  end

  def opponent_box_scores(team)
    return PlayerBoxScore.where(nba_team: opponent(team), nba_matchup: self)
  end

end
