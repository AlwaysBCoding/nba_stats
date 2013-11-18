# Order of the Rake Tasks
  1. Populate NBA Teams            - `rake seed_data:populate_nba_teams`
  2. Populate NBA Players          - `rake seed_data:populate_nba_players`
  3. Fix Inconsistent Player Names - `rake seed_data:fix_inconsistent_player_names`
  4. Populate NBA Matchups List    - `rake seed_data:populate_nba_matchups_list`
  5. Populate NBA Matchups Data    - `rake seed_data:populate_nba_matchups_data`
  6. Populate Team Box Scores      - `rake seed_data:populate_team_box_scores`
  7. Populate Player Box Scores    - `rake seed_data:populate_player_box_scores`

# PLAYER ADJUSTMENTS FROM THE ORIGINAL SCRIPT
  * Update these FROM nba.com names TO the basketball-reference names ( Make a rake task to do this )
  - Players are listed out on the rake task

# LIST OF TEAM ABBREVIATIONS TO QUERY
  * ATL - Atlanta Hawks
  * BOS - Boston Celtics
  * BRK - Brookyln Nets
  * CHA - Charlotte Bobcats
  * CHI - Chicago Bulls
  * CLE - Cleveland Cavaliers
  * DAL - Dallas Mavericks
  * DEN - Denver Nuggets
  * DET - Detroit Pistons
  * GSW - Golden State Warriors
  * HOU - Houston Rockets
  * IND - Indiana Pacers
  * LAC - Los Angeles Clippers
  * LAL - Los Angeles Lakers
  * MEM - Memphis Grizzlies
  * MIA - Miami Heat
  * MIL - Milwaukee Bucks
  * MIN - Minnesota Timberwolves
  * NOP - New Orleans Pelicans
  * NYK - New York Knicks
  * OKC - Oklahoma City Thunder
  * ORL - Orlando Magic
  * PHI - Philadelphia 76ers
  * PHO - Phoenix Suns
  * POR - Portland Trail Blazers
  * SAC - Sacramento Kings
  * SAS - San Antonio Spurs
  * TOR - Toronto Raptors
  * UTA - Utah Jazz
  * WAS - Washington Wizards

# API
  ### GET /team/:abbr.json
    - Team Information
    - Roster, with basic information and links to more detailed information about each player
    - Box Score information of each game, with links to more detailed information

  ### GET /player/:id.json
    - Player Information
    - Year to Date Cumulative Stats
    - Individual stat lines from each game played this season

# VALID LINKS
  ### /teams
    - standings of every nba team

  ### /team/:abbr
    - navigation page for each team

  ### /player/:id
    - navigation page for each player

  ### /nba-matchup/:id
    - box score of a specific matchup

  ### /players OR /stats
    - queryable nba stat table ( NOT IMPLEMENETED YET )

# Notes
1. Brooklyn is abbreviated "BRK" on basketball-reference.com but I've seen it as BKN in other places
2. Phoenix is abbreviated "PHO" on basketball-reference.com but I've seen it as PHX other places
3. I am currently aggregating ot_points together if a game does go into ot since nothing meaningful can be gained from making that information more granular. You can probably calculate the length of a game by checking the total minutes played, not sure if I need to persist that data on the matchup itself, even though that seems like it would be the logical place for it.
4. Trades are going to be an absolute clusterfuck, I'm going to persist the team_id on each player box score

# Environment Variables that need to be set
  * NBA_TWITTER_CONSUMER_KEY
  * NBA_TWITTER_CONSUMER_SECRET
  * NBA_TWITTER_OAUTH_TOKEN
  * NBA_TWITTER+OAUTH_TOKEN_SECRET
