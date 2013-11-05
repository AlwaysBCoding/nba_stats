namespace :seed_data do
  desc "Finds matchups with empty player box scores by team, and populates each player's stat line"
  task :populate_player_box_scores => :environment do
    require "open-uri"

    NbaTeam.all.each do |team|
      puts "STARTING #{team.display_name.upcase}..."

      team.missing_player_box_scores.each do |matchup|
        puts "SEEKING MATCHUP #{matchup.basketball_reference_id} : #{matchup.gamedate}"

        url = "http://www.basketball-reference.com/boxscores/#{matchup.basketball_reference_id}.html"
        doc = Nokogiri::HTML(open(url))

        basic_stats_table    = doc.at_css("##{team.abbr.upcase}_basic")
        basic_stat_rows      = basic_stats_table.css("tbody > tr:not(.thead)")
        advanced_stats_table = doc.at_css("##{team.abbr.upcase}_advanced")
        advanced_stat_rows   = advanced_stats_table.css("tbody > tr:not(.thead)")

        location = nil
        matchup.basketball_reference_id.last(3) == team.abbr.upcase ? location = "home" : location = "away" ;

        basic_stat_rows.each_with_index do |basic_stat_row, index|
          player = NbaPlayer.where(nba_team_id: team.id, display_name: basic_stat_row.at_css("td:nth-child(1)").text).first
          raise "PLAYER NOT FOUND: #{team.abbr.upcase}-#{basic_stat_row.at_css("td:nth-child(1)").text}" unless player.present?

          minutes_played = basic_stat_row.at_css("td:nth-child(2)").text.split(":")
          seconds_played = ((minutes_played[0].to_i * 60) + minutes_played[1].to_i)

          field_goals_made         = basic_stat_row.at_css("td:nth-child(3)").text.to_i
          field_goals_attempted    = basic_stat_row.at_css("td:nth-child(4)").text.to_i
          three_pointers_made      = basic_stat_row.at_css("td:nth-child(6)").text.to_i
          three_pointers_attempted = basic_stat_row.at_css("td:nth-child(7)").text.to_i
          free_throws_made         = basic_stat_row.at_css("td:nth-child(9)").text.to_i
          free_throws_attempted    = basic_stat_row.at_css("td:nth-child(10)").text.to_i
          offensive_rebounds       = basic_stat_row.at_css("td:nth-child(12)").text.to_i
          defensive_rebounds       = basic_stat_row.at_css("td:nth-child(13)").text.to_i
          assists                  = basic_stat_row.at_css("td:nth-child(15)").text.to_i
          steals                   = basic_stat_row.at_css("td:nth-child(16)").text.to_i
          blocks                   = basic_stat_row.at_css("td:nth-child(17)").text.to_i
          turnovers                = basic_stat_row.at_css("td:nth-child(18)").text.to_i
          personal_fouls           = basic_stat_row.at_css("td:nth-child(19)").text.to_i
          points                   = basic_stat_row.at_css("td:nth-child(20)").text.to_i

          true_shooting_percentage        = advanced_stat_rows[index].at_css("td:nth-child(3)").text.to_f
          effective_field_goal_percentage = advanced_stat_rows[index].at_css("td:nth-child(4)").text.to_f
          offensive_rebound_percentage    = advanced_stat_rows[index].at_css("td:nth-child(5)").text.to_f
          defensive_rebound_percentage    = advanced_stat_rows[index].at_css("td:nth-child(6)").text.to_f
          assist_percentage               = advanced_stat_rows[index].at_css("td:nth-child(8)").text.to_f
          steal_percentage                = advanced_stat_rows[index].at_css("td:nth-child(9)").text.to_f
          block_percentage                = advanced_stat_rows[index].at_css("td:nth-child(10)").text.to_f
          turnover_percentage             = advanced_stat_rows[index].at_css("td:nth-child(11)").text.to_f
          usage_percentage                = advanced_stat_rows[index].at_css("td:nth-child(12)").text.to_f
          offensive_rating                = advanced_stat_rows[index].at_css("td:nth-child(13)").text.to_f
          defensive_rating                = advanced_stat_rows[index].at_css("td:nth-child(14)").text.to_f

          PlayerBoxScore.create!({
            nba_player_id: player.id,
            nba_team_id: team.id,
            nba_matchup_id: matchup.id,
            location: location,
            seconds_played: seconds_played,
            field_goals_made: field_goals_made,
            field_goals_attempted: field_goals_attempted,
            three_pointers_made: three_pointers_made,
            three_pointers_attempted: three_pointers_attempted,
            free_throws_made: free_throws_made,
            free_throws_attempted: free_throws_attempted,
            offensive_rebounds: offensive_rebounds,
            defensive_rebounds: defensive_rebounds,
            assists: assists,
            steals: steals,
            blocks: blocks,
            turnovers: turnovers,
            personal_fouls: personal_fouls,
            points: points,
            true_shooting_percentage: true_shooting_percentage,
            effective_field_goal_percentage: effective_field_goal_percentage,
            offensive_rebound_percentage: offensive_rebound_percentage,
            defensive_rebound_percentage: defensive_rebound_percentage,
            assist_percentage: assist_percentage,
            steal_percentage: steal_percentage,
            block_percentage: block_percentage,
            turnover_percentage: turnover_percentage,
            usage_percentage: usage_percentage,
            offensive_rating: offensive_rating,
            defensive_rating: defensive_rating,
            plus_minus: nil
          })

          puts "CREATED BOX SCORE FOR #{matchup.gamedate} : #{player.display_name}"
        end

        puts "========================"
        puts "COMPLETED STAT LINES FOR #{team.abbr.upcase}: #{matchup.gamedate}"
        puts "========================"

      end
    end

    puts "SHUTTING DOWN..."

  end
end
