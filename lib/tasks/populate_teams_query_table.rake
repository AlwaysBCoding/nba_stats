namespace :data do
  desc "Runs the complicated query to generate the NBA Teams query table, then writes the JSON result to a static file, which the page is served from"
  task :teams_query_table => :environment do

    puts "*|=============================================|*"
    puts "PREPARING TO WRITE DATA TO: documents/teams.json"
    puts "*|=============================================|*"

    teams_query_data = []

    NbaTeam.all.each do |team|
      team_query_data = {}

      team_query_data["team_name"] = team.abbr.upcase
      team_query_data["games_played"] = team.games_played
      team_query_data["wins"] = team.won_games.count
      team_query_data["losses"] = team.lost_games.count
      team_query_data["home_wins"] = team.home_games.won_games.count
      team_query_data["home_losses"] = team.home_games.lost_games.count
      team_query_data["away_wins"] = team.away_games.won_games.count
      team_query_data["away_losses"] = team.away_games.lost_games.count
      team_query_data["winning_percentage"] = team.winning_percentage.round(3)
      team_query_data["home_winning_percentage"] = (team.home_games.won_games.count.to_f / team.home_games.count).round(3)
      team_query_data["away_winning_percentage"] = (team.away_games.won_games.count.to_f / team.away_games.count.to_f).round(3)
      team_query_data["last_10_wins"] = team.recent_games(10).select { |bx| bx.result == "win" }.count
      team_query_data["last_10_losses"] = team.recent_games(10).select { |bx| bx.result == "loss" }.count
      team_query_data["possessions"] = team.number_of_possessions
      team_query_data["pace"] = team.pace.round(1)
      team_query_data["offensive_rating"] = team.offensive_rating.round(1)
      team_query_data["defensive_rating"] = team.defensive_rating.round(1)
      team_query_data["net_rating"] = team.net_rating.round(3)
      team_query_data["assist_percentage"] = team.assist_percentage.round(3)
      team_query_data["total_rebound_percentage"] = team.total_rebound_percentage.round(3)
      team_query_data["block_percentage"] = team.block_percentage.round(3)
      team_query_data["steal_percentage"] = team.steal_percentage.round(3)

      teams_query_data << team_query_data
    end

    f = File.open("#{Rails.root}/documents/teams.json", "w")
    f.write(teams_query_data.to_json)
    f.close

    puts "*|=============================================|*"
    puts "WROTE DATA TO: documents/teams.json"
    puts "*|=============================================|*"

  end

end
