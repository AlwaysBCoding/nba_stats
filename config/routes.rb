NbaStats::Application.routes.draw do

  root to: "nba_teams#index"

# TEAMS
  get "/teams" => "nba_teams#index", as: :teams
  get "/team/:abbr" => "nba_teams#show", as: :team

# PLAYERS
  get "/players" => "nba_players#index", as: :players
  get "/player/:id" => "nba_players#show", as: :player

# MATCHUPS
  get "/nba-matchup/:id" => "nba_matchups#show", as: :nba_matchup

# KNOWLEDGE ENGINE
  get "/search" => "search#index", as: :search
  get "/query" => "search#query", as: :query

end
