namespace :seed_data do
  desc "Populates DB with NBA Players"
  task :populate_nba_players => :environment do
    browser = Watir::Browser.new :ff

    teams = NbaTeam.all.select { |team| team.roster.count == 0 }
    puts "Teams without Rosters: #{teams.map(&:abbr).join(',')}"

    teams.each do |team|
      url = "http://stats.nba.com/teamProfile.html?TeamID=#{team.nba_stats_id}"
      browser.goto(url)
      doc = Nokogiri::HTML.parse(browser.html)
      roster_rows = doc.css("table#teamRosterTeamGridContainer tr")
      roster_rows.shift

      roster_rows.each do |row|
        display_name = row.at_css(".col-PLAYER").text
        firstname = display_name.split(" ")[0].try(:downcase)
        lastname = display_name.split(" ")[1].try(:downcase)
        number = row.at_css(".col-NUM").text.to_i
        position = row.at_css(".col-POSITION").text
        height_array = row.at_css(".col-HEIGHT_SORT").text.split("-").map(&:to_i)
        height = (height_array[0] * 12) + height_array[1]
        weight = row.at_css(".col-WEIGHT").text.to_i
        birthdate = DateTime.strptime(row.at_css(".col-BIRTH_DATE_SORT"), "%b %d, %Y")
        experience = row.at_css(".col-EXP_SORT").text.to_i
        college = row.at_css(".col-SCHOOL").text

        player = team.nba_players.create! firstname: firstname, lastname: lastname, display_name: display_name, number: number, position: position, height: height, weight: weight, birthdate: birthdate, experience: experience, college: college
        puts "CREATED #{team.name.upcase} PLAYER : #{player.display_name}"
      end
    end

    puts "SHUTTING DOWN..."
    browser.close

  end
end
