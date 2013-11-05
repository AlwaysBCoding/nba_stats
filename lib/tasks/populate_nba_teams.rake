namespace :seed_data do
  desc "Populates DB with NBA Teams"
  task :populate_nba_teams => :environment do
    # NbaTeam.destroy_all
    # puts "Destroying all NBA Teams..."

    NbaTeam.create! city: "atlanta", name: "hawks", abbr: "atl", conference: "eastern", division: "southeast", nba_stats_id: "1610612737", display_name: "Atlanta Hawks"
    NbaTeam.create! city: "boston", name: "celtics", abbr: "bos", conference: "eastern", division: "atlantic", nba_stats_id: "1610612738", display_name: "Boston Celtics"
    NbaTeam.create! city: "brookyln", name: "nets", abbr: "brk", conference: "eastern", division: "atlantic", nba_stats_id: "1610612751", display_name: "Brooklyn Nets"
    NbaTeam.create! city: "charlotte", name: "bobcats", abbr: "cha", conference: "eastern", division: "southeast", nba_stats_id: "1610612766", display_name: "Charlotte Bobcats"
    NbaTeam.create! city: "chicago", name: "bulls", abbr: "chi", conference: "eastern", division: "central", nba_stats_id: "1610612741", display_name: "Chicago Bulls"

    NbaTeam.create! city: "cleveland", name: "cavaliers", abbr: "cle", conference: "eastern", division: "central", nba_stats_id: "1610612739", display_name: "Cleveland Cavaliers"
    NbaTeam.create! city: "detroit", name: "pistons", abbr: "det", conference: "eastern", division: "central", nba_stats_id: "1610612765", display_name: "Detroit Pistons"
    NbaTeam.create! city: "indiana", name: "pacers", abbr: "ind", conference: "eastern", division: "central", nba_stats_id: "1610612754", display_name: "Indiana Pacers"
    NbaTeam.create! city: "miami", name: "heat", abbr: "mia", conference: "eastern", division: "southeast", nba_stats_id: "1610612748", display_name: "Miami Heat"
    NbaTeam.create! city: "milwaukee", name: "bucks", abbr: "mil", conference: "eastern", division: "central", nba_stats_id: "1610612749", display_name: "Milwaukee Bucks"

    NbaTeam.create! city: "new york", name: "knicks", abbr: "nyk", conference: "eastern", division: "atlantic", nba_stats_id: "1610612752", display_name: "New York Knicks"
    NbaTeam.create! city: "orlando", name: "magic", abbr: "orl", conference: "eastern", division: "southeast", nba_stats_id: "1610612753", display_name: "Orlando Magic"
    NbaTeam.create! city: "philadelphia", name: "76ers", abbr: "phi", conference: "eastern", division: "atlantic", nba_stats_id: "1610612755", display_name: "Philadelphia 76ers"
    NbaTeam.create! city: "toronto", name: "raptors", abbr: "tor", conference: "eastern", division: "atlantic", nba_stats_id: "1610612761", display_name: "Toronto Raptors"
    NbaTeam.create! city: "washington", name: "wizards", abbr: "was", conference: "eastern", division: "southeast", nba_stats_id: "1610612764", display_name: "Washington Wizards"

    NbaTeam.create! city: "dallas", name: "mavericks", abbr: "dal", conference: "western", division: "southwest", nba_stats_id: "1610612742", display_name: "Dallas Mavericks"
    NbaTeam.create! city: "denver", name: "nuggets", abbr: "den", conference: "western", division: "northwest", nba_stats_id: "1610612743", display_name: "Denver Nuggets"
    NbaTeam.create! city: "golden state", name: "warriors", abbr: "gsw", conference: "western", division: "pacific", nba_stats_id: "1610612744", display_name: "Golden State Warriors"
    NbaTeam.create! city: "houston", name: "rockets", abbr: "hou", conference: "western", division: "southwest", nba_stats_id: "1610612745", display_name: "Houston Rockets"
    NbaTeam.create! city: "los angeles", name: "clippers", abbr: "lac", conference: "western", division: "pacific", nba_stats_id: "1610612746", display_name: "Los Angeles Clippers"

    NbaTeam.create! city: "los angeles", name: "lakers", abbr: "lal", conference: "western", division: "pacific", nba_stats_id: "1610612747", display_name: "Los Angeles Lakers"
    NbaTeam.create! city: "memphis", name: "grizzlies", abbr: "mem", conference: "western", division: "southwest", nba_stats_id: "1610612763", display_name: "Memphis Grizzlies"
    NbaTeam.create! city: "minnesota", name: "timberwolves", abbr: "min", conference: "western", division: "northwest", nba_stats_id: "1610612750", display_name: "Minnesota Timberwolves"
    NbaTeam.create! city: "new orleans", name: "pelicans", abbr: "nop", conference: "western", division: "southwest", nba_stats_id: "1610612740", display_name: "New Orleans Pelicans"
    NbaTeam.create! city: "oklahoma city", name: "thunder", abbr: "okc", conference: "western", division: "northwest", nba_stats_id: "1610612760", display_name: "Oklahoma City Thunder"

    NbaTeam.create! city: "phoenix", name: "suns", abbr: "pho", conference: "western", division: "pacific", nba_stats_id: "1610612756", display_name: "Phoenix Suns"
    NbaTeam.create! city: "portland", name: "trailblazers", abbr: "por", conference: "western", division: "northwest", nba_stats_id: "1610612757", display_name: "Portland Trail Blazers"
    NbaTeam.create! city: "sacramento", name: "kings", abbr: "sac", conference: "western", division: "pacific", nba_stats_id: "1610612758", display_name: "Sacramento Kings"
    NbaTeam.create! city: "san antonio", name: "spurs", abbr: "sas", conference: "western", division: "southwest", nba_stats_id: "1610612759", display_name: "San Antonio Spurs"
    NbaTeam.create! city: "utah", name: "jazz", abbr: "uta", conference: "western", division: "northwest", nba_stats_id: "1610612762", display_name: "Utah Jazz"

    puts "Creating 30 NBA Teams..."
  end
end
