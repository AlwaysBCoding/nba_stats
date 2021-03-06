namespace :data do
  desc "Populates DB with the matchup data for each matchup"
  task :nba_matchups_data => :environment do
    require "open-uri"

    empty_matchups = NbaMatchup.where("home_team_id IS NULL OR away_team_id IS NULL")
    empty_matchups.each do |matchup|
      url = "http://www.basketball-reference.com/boxscores/#{matchup.basketball_reference_id}.html"
      doc = Nokogiri::HTML(open(url))

      matchup_string = doc.at_css("h1").text

      referee_array = doc.css("a[href^='/referees']")
      referees = referee_array.map(&:text).last(3)
      away_team = NbaTeam.find_by_display_name(matchup_string.match(/^(.*?)\sat/)[1])
      home_team = NbaTeam.find_by_display_name(matchup_string.match(/\sat(.*?)Box Score/)[1].strip)

      matchup.update_attributes(home_team_id: home_team.id, away_team_id: away_team.id, referees: referees)
      puts "Updated Matchup #{matchup.gamedate}: #{away_team.display_name} @ #{home_team.display_name} with referees: #{referees.join(',')}"
    end

    puts "SHUTTING DOWN..."

  end
end
