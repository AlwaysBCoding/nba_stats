namespace :seed_data do
  desc "Populates DB with the matchup data for each matchup"
  task :populate_nba_matchups_data => :environment do
    browser = Watir::Browser.new :ff

    NbaMatchup.all.each do |matchup|
      url = "http://www.basketball-reference.com/boxscores/#{matchup.basketball_reference_id}.html"
      browser.goto(url)
      doc = Nokogiri::HTML.parse(browser.html)

      matchup_string = doc.at_css("h1").text

      referees = doc.css("a[href^='/referees']")
      referees.map!(&:text).last(3)
      away_team = NbaTeam.find_by_display_name(matchup_string.match(/^(.*?)\sat/)[1])
      home_team = NbaTeam.find_by_display_name(matchup_string.match(//)[1].strip)

      matchup.update_attributes(home_team_id: home_team.id, away_team_id: away_team.id, referees: referees)
      puts "Updated Matchup #{matchup.gamedate}: #{away_team} @ #{home_team} with referees: #{referees.join(',')}"
    end

    puts "SHUTTING DOWN..."
    broswer.close

  end
end
