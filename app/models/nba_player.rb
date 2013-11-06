class NbaPlayer < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  has_many :player_box_scores

# CONVENIENCE METHODS
  def self.search(player_name)
    self.find_by_display_name(player_name)
  end

# QUERY METHODS
  def points_per_game
    (sum_stat_total(:points) / games_played.to_f).round(2)
  end

  def assists_per_game
    (sum_stat_total(:assists) / games_played.to_f).round(2)
  end

  def rebounds_per_game
    ((sum_stat_total(:offensive_rebounds) + sum_stat_total(:defensive_rebounds)) / games_played.to_f).round(2)
  end

  def steals_per_game
    (sum_stat_total(:steals) / games_played.to_f).round(2)
  end

  def blocks_per_game
    (sum_stat_total(:blocks) / games_played.to_f).round(2)
  end

# PRIVATE METHODS
  def sum_stat_total(stat)
    player_box_scores.pluck(stat).sum
  end

  def games_played
    player_box_scores.count
  end

end
