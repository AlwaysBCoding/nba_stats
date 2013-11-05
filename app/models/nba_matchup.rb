class NbaMatchup < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :home_team, class_name: "NbaTeam", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "NbaTeam", foreign_key: "away_team_id"
  has_many :team_box_scores
  has_many :player_box_scores

# SCOPES
  scope :matchups_for_team, ->(abbr) {
    where("home_team_id = ? OR away_team_id = ?", NbaTeam.find_by_abbr(abbr).id, NbaTeam.find_by_abbr(abbr).id)
  }

end
