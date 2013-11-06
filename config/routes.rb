NbaStats::Application.routes.draw do

  root to: "nba_teams#index"

  get "/teams" => "nba_teams#index", as: :teams
  get "/teams/:abbr" => "nba_teams#show", as: :team

  get "/players/:id" => "nba_players#show", as: :player
end
