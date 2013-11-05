class NbaPlayer < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  has_many :player_box_scores

end
