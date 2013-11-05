class PlayerBoxScore < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_player
  belongs_to :nba_matchup

end
