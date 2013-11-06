# Order of the Rake Tasks
1. Populate NBA Teams            - `rake seed_data:populate_nba_teams`
2. Populate NBA Players          - `rake seed_data:populate_nba_players`
3. Fix Inconsistent Player Names - `rake seed_data:fix_inconsistent_player_names`
4. Populate NBA Matchups List    - `rake seed_data:populate_nba_matchups_list`
5. Populate NBA Matchups Data    - `rake seed_data:populate_nba_matchups_data`
6. Populate Team Box Scores      - `rake seed_data:populate_team_box_scores`
7. Populate Player Box Scores    - `rake seed_data:populate_player_box_scores`

# Notes
1. Brooklyn is abbreviated "BRK" on basketball-reference.com but I've seen it as BKN in other places
2. Phoenix is abbreviated "PHO" on basketball-reference.com but I've seen it as PHX other places
3. I am currently aggregating ot_points together if a game does go into ot since nothing meaningful can be gained from making that information more granular. You can probably calculate the length of a game by checking the total minutes played, not sure if I need to persist that data on the matchup itself, even though that seems like it would be the logical place for it.
4. Trades are going to be an absolute clusterfuck, I'm going to persist the team_id on each player box score

# PLAYER ADJUSTMENTS FROM THE ORIGINAL SCRIPT
  * Update these FROM nba.com names TO the basketball-reference names ( Make a rake task to do this )
  - Players are listed out on the rake task

# FLOW
### Team/Index
  - Lists Standings

### Team/Show
  - Lists Roster

### Player/Show
  - Lists all Stats

### Player/Index
  - Lists League Leaders
