class NbaPlayer < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_team
  has_many :player_box_scores

# CONVENIENCE METHODS
  def self.search(player_name)
    self.find_by_display_name(player_name)
  end

# STATS QUERY METHODS
  def points_per(interval)
    case interval
    when :game
      return (sum_stat_total(:points) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:points) / minutes_played) * 48)
    end
  end

  def assists_per(interval)
    case interval
    when :game
      return (sum_stat_total(:assists) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:assists) / minutes_played) * 48)
    end
  end

  def offensive_rebounds_per(interval)
    case interval
    when :game
      return (sum_stat_total(:offensive_rebounds) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:offensive_rebounds) / minutes_played) * 48)
    end
  end

  def defensive_rebounds_per(interval)
    case interval
    when :game
      return (sum_stat_total(:defensive_rebounds) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:defensive_rebounds) / minutes_played) * 48)
    end
  end

  def total_rebounds_per(interval)
    case interval
    when :game
      return ((sum_stat_total(:offensive_rebounds) + sum_stat_total(:defensive_rebounds)) / games_played)
    when :fourtyeight
      return (((sum_stat_total(:offensive_rebounds) + sum_stat_total(:defensive_rebounds)) / minutes_played) * 48)
    end
  end

  def steals_per(interval)
    case interval
    when :game
      return (sum_stat_total(:steals) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:steals) / minutes_played) * 48)
    end
  end

  def blocks_per(interval)
    case interval
    when :game
      return (sum_stat_total(:blocks) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:blocks) / minutes_played) * 48)
    end
  end

  def minutes_per(interval)
    case interval
    when :game
      return (minutes_played / games_played)
    end
  end

  def turnovers_per(interval)
    case interval
    when :game
      return (sum_stat_total(:turnovers) / games_played)
    when :fourtyeight
      return ((sum_stat_total(:turnovers) / minutes_played) * 48)
    end
  end

# HELPER METHODS
  def sum_stat_total(stat)
    player_box_scores.pluck(stat).sum
  end

  def sum_stat_percentage(stat1, stat2)
    ( sum_stat_total(stat1) / sum_stat_total(stat2).to_f )
  end

  def games_played
    player_box_scores.count.to_f
  end

  def minutes_played
    player_box_scores.pluck(:seconds_played).sum / 60.0
  end

end
