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
  def record(location=nil)
    case location
    when :home
      [number_of_wins(:home), number_of_losses(:home)]
    when :away
      [number_of_wins(:away), number_of_losses(:away)]
    else
      [number_of_wins, number_of_losses]
    end
  end

  def winning_percentage
    (won_games.count / games_played.to_f).round(3)
  end

  def games_played
    team_box_scores.count
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
