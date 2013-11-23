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

  def number_of_possessions
    fga     = sum_stat_total(:field_goals_attempted)
    fgm     = sum_stat_total(:field_goals_made)
    fta     = sum_stat_total(:free_throws_attempted)
    orb     = sum_stat_total(:offensive_rebounds)
    drb     = sum_stat_total(:defensive_rebounds)
    tov     = sum_stat_total(:turnovers)
    # opp_fga = all_opponent_box_scores.map(&:field_goals_attempted).sum
    # opp_fgm = all_opponent_box_scores.map(&:field_goals_made).sum
    # opp_fta = all_opponent_box_scores.map(&:free_throws_attempted).sum
    # opp_orb = all_opponent_box_scores.map(&:offensive_rebounds).sum
    # opp_drb = all_opponent_box_scores.map(&:defensive_rebounds).sum
    # opp_tov = all_opponent_box_scores.map(&:turnovers).sum

    pos_estimate = ( fga - orb + tov + (0.44 * fta) )
    # opp_pos_estimate = 0.96 * ( opp_fga - opp_orb + opp_tov + (0.44 * opp_fta) )
    # return (pos_estimate + opp_pos_estimate) * 0.5
    return pos_estimate
  end

# HELPER METHODS
  def sum_stat_total(stat)
    player_box_scores.pluck(stat).sum
  end

  def sum_opponent_stat_total(stat)
    all_opponent_box_scores.map { |bx| bx.send(stat) }.sum
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
