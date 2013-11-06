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
  def nba_matchups
    home_matchups + away_matchups
  end

  def roster
    nba_players
  end

# STATS QUERY METHODS
  def record
    "#{number_of_wins}-#{number_of_losses}"
  end

  def win_percentage
    (number_of_wins / games_played.to_f).round(3)
  end

  def number_of_wins
    TeamBoxScore.where(nba_team: self, result: "win").count
  end

  def number_of_wins_at(location)
    return TeamBoxScore.where(nba_team: self, result: "win", location: "home").count if location == :home
    return TeamBoxScore.where(nba_team: self, result: "win", location: "away").count if location == :away
  end

  def number_of_losses
    TeamBoxScore.where(nba_team: self, result: "loss").count
  end

  def number_of_losses_at(location)
    return TeamBoxScore.where(nba_team: self, result: "loss", location: "home").count if location == :home
    return TeamBoxScore.where(nba_team: self, result: "loss", location: "away").count if location == :away
  end

  def games_played
    team_box_scores.count
  end

  def last_10_record
    last_10 = team_box_scores.includes(:nba_matchup).sort { |bx1, bx2| bx2.gamedate <=> bx1.gamedate }.last(10)
    wins = last_10.select { |bx| bx.result == "win" }.count
    losses = last_10.select { |bx| bx.result == "loss" }.count
    return [wins, losses]
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
