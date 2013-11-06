class PlayerBoxScore < ActiveRecord::Base

# ASSOCIATIONS
  belongs_to :nba_player
  belongs_to :nba_team
  belongs_to :nba_matchup

# DELEGATIONS
  def gamedate
    nba_matchup.gamedate
  end

  def opponent
    nba_matchup.opponent(nba_team)
  end

  def result
    TeamBoxScore.where(nba_team: nba_team, nba_matchup: nba_matchup).first.result
  end

# VIEW METHODS (SHOULD BE IN A DECORATOR...)
  def display_name
    "#{nba_matchup.gamedate.strftime('%b %d %Y')} #{display_location} #{opponent.abbr.upcase}"
  end

  def display_location
    return "vs" if location == "home"
    return "at" if location == "away"
  end

end
