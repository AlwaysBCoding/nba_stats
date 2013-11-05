namespace :seed_data do
  desc "Populates DB with NBA Matchups"
  task :populate_nba_matchups => :environment do
    browser = Watir::Browser.new :ff

    dates = [
      [10, 29, 2013],
      [10, 30, 2013],
      [10, 31, 2013],
      [11, 01, 2013],
      [11, 02, 2013],
      [11, 03, 2013],
      [11, 04, 2013]
    ]

    dates.each do |date|
      url = "http://www.basketball-reference.com/boxscores/index.cgi?month=#{date[0]}&day=#{date[1]}&year=#{date[2]}"
      browser.goto(url)
      doc = Nokogiri::HTML.parse(browser.html)

      games = doc.css("div#boxes a[href^='/boxscores']")
      games.each do |game|
        href = game.attr("href")
        basketball_reference_id = href.gsub(/[^0-9A-Z]/, "")
        NbaMatchup.create! basketball_reference_id: basketball_reference_id, gamedate: DateTime.strptime("#{date[0]} #{date[1]} #{date[2]}", "%m %d %Y")
        puts "Created NBA Matchup on #{date[0]} #{date[1]} #{date[2]}: #{basketball_reference_id}"
      end

    end

    puts "SHUTTING DOWN..."
    browser.close

  end
end
