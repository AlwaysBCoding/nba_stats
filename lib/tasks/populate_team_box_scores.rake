namespace :seed_data do
  desc "Populates each matchup with the team box scores"
  task :populate_team_box_scores => :environment do
    require "open-uri"

    NbaTeam.all.each do |team|
      team.missing_box_scores.each do |matchup|
        url = "http://www.basketball-reference.com/boxscores/#{matchup.basketball_reference_id}.html"
        doc = Nokogiri::HTML(open(url))

        location, scoring_row, ot_points, result = nil, nil, nil, nil
        matchup.basketball_reference_id.last(3) == team.abbr.upcase ? location = "home" : location = "away" ;

        scoring_table = doc.at_css("td > table.nav_table.stats_table:not(.no_highlight)")
        scoring_row, opponent_scoring_row = scoring_table.at_css("tr:nth-child(3)"), scoring_table.at_css("tr:nth-child(4)") if location == "away"
        scoring_row, opponent_scoring_row = scoring_table.at_css("tr:nth-child(4)"), scoring_table.at_css("tr:nth-child(3)") if location == "home"

        raise "THE WRONG SCORING ROW IS SELECTED" if scoring_row.at_css("td:nth-child(1) a").text != team.abbr.upcase
        q1_points = scoring_row.at_css("td:nth-child(2)").text.to_i
        q2_points = scoring_row.at_css("td:nth-child(3)").text.to_i
        q3_points = scoring_row.at_css("td:nth-child(4)").text.to_i
        q4_points = scoring_row.at_css("td:nth-child(5)").text.to_i
        score = scoring_row.at_css("td:last-child").text.to_i
        opponent_score = opponent_scoring_row.at_css("td:last-child").text.to_i
        score > opponent_score ? result = "win" : result = "loss" ;

        # to compensate for the fact that the game could have gone into one or more overtimes
        if scoring_row.css("td").length > 6
          ot_points = score - (q1_points + q2_points + q3_points + q4_points)
        end

        four_factor_table = doc.at_css("#div_four_factors")
        factor_row = four_factor_table.at_css("tbody tr:nth-child(1)") if location == "away"
        factor_row = four_factor_table.at_css("tbody tr:nth-child(2)") if location == "home"

        raise "THE WRONG FACTOR ROW IS SELECTED" if factor_row.at_css("td:nth-child(1) a").text != team.abbr.upcase
        pace = factor_row.at_css("td:nth-child(2)").text.to_f
        effective_field_goal_percentage = factor_row.at_css("td:nth-child(3)").text.to_f
        turnover_percentage = factor_row.at_css("td:nth-child(4)").text.to_f
        offensive_rebound_percentage = factor_row.at_css("td:nth-child(5)").text.to_f
        free_throw_rate = factor_row.at_css("td:nth-child(6)").text.to_f
        offensive_rating = factor_row.at_css("td:nth-child(7)").text.to_f

        TeamBoxScore.create!({
          nba_team_id: team.id,
          nba_matchup_id: matchup.id,
          location: location,
          q1_points: q1_points,
          q2_points: q2_points,
          q3_points: q3_points,
          q4_points: q4_points,
          ot_points: ot_points,
          score: score,
          result: result,
          pace: pace,
          effective_field_goal_percentage: effective_field_goal_percentage,
          turnover_percentage: turnover_percentage,
          offensive_rebound_percentage: offensive_rebound_percentage,
          free_throw_rate: free_throw_rate,
          offensive_rating: offensive_rating
        })

        puts "Created TEAM Box Score for #{team.display_name}: #{matchup.basketball_reference_id}"
      end
    end

    puts "SHUTTING DOWN..."

  end
end
