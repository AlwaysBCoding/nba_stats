namespace :file do
  desc "Generates CSV file of player box score data"
  task :player_box_score_data => :environment do
    f = File.open("#{Rails.root}/documents/2013_player_box_scores.csv", "w")
    f.write("player_name,team,opponent,location,gamedate,seconds_played,field_goals_made,field_goals_attempted,three_pointers_made,three_pointers_attempted,free_throws_made,free_throws_attempted,offensive_rebounds,defensive_rebounds,assists,steals,blocks,turnovers,personal_fouls,points\n")

    PlayerBoxScore.includes(:nba_team).includes(:nba_player).includes(:nba_matchup).all.each do |bx|
      data = ""
      data += "#{bx.player.display_name},"
      data += "#{bx.nba_team.abbr},"
      data += "#{bx.opponent.abbr},"
      data += "#{bx.location},"
      data += "#{bx.nba_matchup.gamedate},"
      data += "#{bx.seconds_played},"
      data += "#{bx.field_goals_made},"
      data += "#{bx.field_goals_attempted},"
      data += "#{bx.three_pointers_made},"
      data += "#{bx.three_pointers_attempted},"
      data += "#{bx.free_throws_made},"
      data += "#{bx.free_throws_attempted},"
      data += "#{bx.offensive_rebounds},"
      data += "#{bx.defensive_rebounds},"
      data += "#{bx.assists},"
      data += "#{bx.steals},"
      data += "#{bx.blocks},"
      data += "#{bx.turnovers},"
      data += "#{bx.personal_fouls},"
      data += "#{bx.points}"
      data += "\n"

      f.write(data)
      puts "Wrote data for: #{bx.id}"
    end

    f.close

  end
end
