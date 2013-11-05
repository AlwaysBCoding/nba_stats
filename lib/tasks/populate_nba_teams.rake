namespace :seed_data do
  desc "Populates DB with NBA Teams"
  task :populate_nba_teams => :environment do
    NBATeam.destroy_all
    puts "Destroying all NBA Teams..."

    NBATeam.create! city: "atlanta", name: "hawks", abbr: "atl", conference: "eastern", division: "southeast", nba_stats_id: "1610612737"
    NBATeam.create! city: "boston", name: "celtice", abbr: "bos", conference: "eastern", division: "atlantic", nba_stats_id: "1610612738"
    NBATeam.create! city: "brookyln", name: "nets", abbr: "bkn", conference: "eastern", division: "atlantic", nba_stats_id: "1610612751"
    NBATeam.create! city: "charlotte", name: "bobcats", abbr: "cha", conference: "eastern", division: "southeast", nba_stats_id: "1610612766"
    NBATeam.create! city: "chicago", name: "bulls", abbr: "chi", conference: "eastern", division: "central", nba_stats_id: "1610612741"

    NBATeam.create! city: "cleveland", name: "cavaliers", abbr: "cle", conference: "eastern", division: "central", nba_stats_id: "1610612739"
    NBATeam.create! city: "detroit", name: "pistons", abbr: "det", conference: "eastern", division: "central", nba_stats_id: "1610612765"
    NBATeam.create! city: "indiana", name: "pacers", abbr: "ind", conference: "eastern", division: "central", nba_stats_id: "1610612754"
    NBATeam.create! city: "miami", name: "heat", abbr: "mia", conference: "eastern", division: "southeast", nba_stats_id: "1610612748"
    NBATeam.create! city: "milwaukee", name: "bucks", abbr: "mil", conference: "eastern", division: "central", nba_stats_id: "1610612749"

    NBATeam.create! city: "new york", name: "knicks", abbr: "nyk", conference: "eastern", division: "atlantic", nba_stats_id: "1610612752"
    NBATeam.create! city: "orlando", name: "magic", abbr: "orl", conference: "eastern", division: "southeast", nba_stats_id: "1610612753"
    NBATeam.create! city: "philadelphia", name: "76ers", abbr:" phi", conference: "eastern", division: "atlantic", nba_stats_id: "1610612755"
    NBATeam.create! city: "toronto", name: "raptors", abbr: "tor", conference: "eastern", division: "atlantic", nba_stats_id: "1610612761"
    NBATeam.create! city: "washington", name: "wizards", abbr: "was", conference: "eastern", division: "southeast", nba_stats_id: "1610612764"

    NBATeam.create! city: "dallas", name: "mavericks", abbr: "dal", conference: "western", division: "southwest", nba_stats_id: "1610612742"
    NBATeam.create! city: "denver", name: "nuggets", abbr: "den", conference: "western", division: "northwest", nba_stats_id: "1610612743"
    NBATeam.create! city: "golden state", name: "warriors", abbr: "gsw", conference: "western", division: "pacific", nba_stats_id: "1610612744"
    NBATeam.create! city: "houston", name: "rockets", abbr: "hou", conference: "western", division: "southwest", nba_stats_id: "1610612745"
    NBATeam.create! city: "los angeles", name: "clippers", abbr: "lac", conference: "western", division: "pacific", nba_stats_id: "1610612746"

    NBATeam.create! city: "los angeles", name: "lakers", abbr: "lal", conference: "western", division: "pacific", nba_stats_id: "1610612747"
    NBATeam.create! city: "memphis", name: "grizzlies", abbr: "mem", conference: "western", division: "southwest", nba_stats_id: "1610612763"
    NBATeam.create! city: "minnesota", name: "timberwolves", abbr: "min", conference: "western", division: "northwest", nba_stats_id: "1610612750"
    NBATeam.create! city: "new orleans", name: "pelicans", abbr: "nop", conference: "western", division: "southwest", nba_stats_id: "1610612740"
    NBATeam.create! city: "oklahoma city", name: "thunder", abbr: "okc", conference: "western", division: "northwest", nba_stats_id: "1610612760"

    NBATeam.create! city: "phoenix", name: "suns", abbr: "phx", conference: "western", division: "pacific", nba_stats_id: "1610612756"
    NBATeam.create! city: "portland", name: "trailblazers", abbr: "por", conference: "western", division: "northwest", nba_stats_id: "1610612757"
    NBATeam.create! city: "sacramento", name: "kings", abbr: "sac", conference: "western", division: "pacific", nba_stats_id: "1610612758"
    NBATeam.create! city: "san antonio", name: "spurs", abbr: "sas", conference: "western", division: "southwest", nba_stats_id: "1610612759"
    NBATeam.create! city: "utah", name: "jazz", abbr: "uta", conference: "western", division: "northwest", nba_stats_id: "1610612762"

    puts "Creating 30 NBA Teams..."
  end
end
