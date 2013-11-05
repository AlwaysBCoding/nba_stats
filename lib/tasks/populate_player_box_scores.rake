namespace :seed_data do
  desc "Finds matchups with empty player box scores by team, and populates each player's stat line"
  task :populate_player_box_scores => :environment do
    require "open-uri"

    NbaTeam.all.each do |team|
      team.missing_player_box_scores.each do |matchup|
        url = "http://www.basketball-reference.com/boxscores/#{matchup.basketball_reference_id}.html"
        doc = Nokogiri::HTML(open(url))

        basic_stats_table = doc.at_css("##{team.abbr.upcase}_basic")
        advanced_stats_table = doc.at_css("##{team.abbr.upcase}_advanced")

        basic_stat_rows = basic_stats_table.css("tbody > tr:not(.thead)")
        basic_stat_rows.each do |basic_stat_row|
          puts basic_stat_row.at_css("td:nth-child(1)").text

          # PlayerBoxScore.create!({
          #   nba_player_id: ?,
          #   nba_team_id: team.id,
          #   nba_matchup_id: matchup.id,
          #   location: ?,
          #   seconds_played: ?,
          #   field_goals_made: ?,
          #   field_goals_attempted: ?,
          #   three_pointers_made: ?,
          #   three_pointers_attempted: ?,
          #   free_throws_made: ?,
          #   free_throws_attempted: ?,
          #   offensive_rebounds: ?,
          #   defensive_rebounds: ?,
          #   assists: ?,
          #   steals: ?,
          #   blocks: ?,
          #   turnovers: ?,
          #   personal_fouls: ?,
          #   points: ?,
          #   offensive_rating: ?,
          #   defensive_rating: ?.
          # })
        end

        raise "STOP"

      end
    end

  end
end
