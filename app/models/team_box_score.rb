class TeamBoxScore < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  belongs_to :nba_matchup

# SCOPES
  scope :ordered_box_scores_for_team, ->(abbr) {
    joins(:nba_matchup).where(nba_team: NbaTeam.find_by_abbr(abbr)).order("gamedate DESC")
  }

end
