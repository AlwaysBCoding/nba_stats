NbaStats::Application.routes.draw do

  root to: "nba_teams#index"

  get "/teams" => "nba_teams#index", as: :teams
  get "/team/:abbr" => "nba_teams#show", as: :team

  get "/player/:id" => "nba_players#show", as: :player

  get "/nba-matchup/:id" => "nba_matchups#show", as: :nba_matchup
end
