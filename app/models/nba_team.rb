class NbaTeam < ActiveRecord::Base

# ASSOCIATIONS
  has_many :nba_players
  has_many :home_matchups, class_name: "NbaMatchup", foreign_key: "home_team_id"
  has_many :away_matchups, class_name: "NbaMatchup", foreign_key: "away_team_id"
  has_many :team_box_scores
  has_many :player_box_scores

# CONFIGURATION
  def to_param
    self.abbr
  end

# SCOPES
  %w[atlantic central southeast northwest pacific southwest].each do |division|
    scope division, -> { where(division: division) }
  end

# CONVENIENCE METHODS
  def self.q(abbr)
    self.find_by_abbr(abbr)
  end

  def nba_matchups
    home_matchups + away_matchups
  end

  def roster
    nba_players
  end

  def won_games
    team_box_scores.won_games
  end

  def lost_games
    team_box_scores.lost_games
  end

  def home_games
    team_box_scores.home_games
  end

  def away_games
    team_box_scores.away_games
  end

  def recent_games(n)
    team_box_scores.recent(n)
  end

# STATS QUERY METHODS
  def record
    "#{won_games} - #{lost_games}"
  end

  def pace
    ( number_of_possessions / (sum_stat_total(:seconds_played) / 300 ) ) * 48
  end

  def winning_percentage
    (won_games.count / games_played.to_f).round(3)
  end

  def games_played
    team_box_scores.count
  end

  def offensive_rating
    ( sum_stat_total(:points) / number_of_possessions ) * 100
  end

  def defensive_rating
    ( sum_opponent_stat_total(:points) / number_of_possessions ) * 100
  end

  def net_rating
    offensive_rating - defensive_rating
  end

  def assist_percentage
    sum_stat_total(:assists) / sum_stat_total(:field_goals_made)
  end

  def block_percentage
    sum_stat_total(:blocks) / ( sum_opponent_stat_total(:field_goals_attempted) - sum_opponent_stat_total(:three_pointers_attempted) )
  end

  def steal_percentage
    sum_stat_total(:steals) / number_of_opponent_possessions
  end

  def total_rebound_percentage
    total_team_rebounds = sum_stat_total(:offensive_rebounds) + sum_stat_total(:defensive_rebounds)
    total_opponent_team_rebounds = sum_opponent_stat_total(:offensive_rebounds) + sum_opponent_stat_total(:defensive_rebounds)
    total_available_rebounds = total_team_rebounds + total_opponent_team_rebounds
    total_team_rebounds / total_available_rebounds
  end

  def number_of_possessions
    fga     = sum_stat_total(:field_goals_attempted)
    fgm     = sum_stat_total(:field_goals_made)
    fta     = sum_stat_total(:free_throws_attempted)
    orb     = sum_stat_total(:offensive_rebounds)
    drb     = sum_stat_total(:defensive_rebounds)
    tov     = sum_stat_total(:turnovers)

    return ( fga - orb + tov + (0.44 * fta) )
    # opp_pos_estimate = 0.96 * ( opp_fga - opp_orb + opp_tov + (0.44 * opp_fta) )
    # return (pos_estimate + opp_pos_estimate) * 0.5
  end

  def number_of_opponent_possessions
    opp_fga = sum_opponent_stat_total(:field_goals_attempted)
    opp_fgm = sum_opponent_stat_total(:field_goals_made)
    opp_fta = sum_opponent_stat_total(:free_throws_attempted)
    opp_orb = sum_opponent_stat_total(:offensive_rebounds)
    opp_drb = sum_opponent_stat_total(:defensive_rebounds)
    opp_tov = sum_opponent_stat_total(:turnovers)

    return ( opp_fga - opp_orb + opp_tov + (0.44 * opp_fta) )
  end

# HELPER METHODS
  def sum_stat_total(stat)
    player_box_scores.pluck(stat).sum.to_f
  end

  def sum_opponent_stat_total(stat)
    all_opponent_box_scores.map { |bx| bx.send(stat) }.sum.to_f
  end

  def all_opponent_box_scores
    nba_matchups.collect { |matchup| matchup.opponent_box_scores(self) }.flatten
  end

# QUERY METHODS
  def missing_team_box_scores
    nba_matchups - team_box_scores.map(&:nba_matchup)
  end

  def box_scores_from_matchup(matchup)
    PlayerBoxScore.where(nba_team_id: self.id, nba_matchup_id: matchup.id)
  end

  # This query is really inefficient because it's loading every single player_box_score into memory to find the ones that haven't been added
  # there is a much better way to do this with SQL instead of lading all the records into memory, i just dont know the arel for it
  def missing_player_box_scores
    nba_matchups - player_box_scores.map(&:nba_matchup)
  end


end
