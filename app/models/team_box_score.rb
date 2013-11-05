class TeamBoxScore < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  belongs_to :nba_matchup

end
