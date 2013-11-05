class CreatePlayerBoxScores < ActiveRecord::Migration
  def change
    create_table :player_box_scores do |t|
      t.belongs_to :nba_player
      t.belongs_to :nba_team
      t.belongs_to :nba_matchup
      t.string :location
      t.integer :seconds_played
      t.integer :field_goals_made
      t.integer :field_goals_attempted
      t.integer :three_pointers_made
      t.integer :three_pointers_attempted
      t.integer :free_throws_made
      t.integer :free_throws_attempted
      t.integer :offensive_rebounds
      t.integer :defensive_rebounds
      t.integer :assists
      t.integer :steals
      t.integer :blocks
      t.integer :turnovers
      t.integer :personal_fouls
      t.integer :points
      t.decimal :true_shooting_percentage, precision: 4, scale: 3
      t.decimal :effective_field_goal_percentage, precision: 4, scale: 3
      t.decimal :offensive_rebound_percentage, precision: 4, scale: 3
      t.decimal :defensive_rebound_percentage, precision: 4, scale: 3
      t.decimal :assist_percentage, precision: 3, scale: 1
      t.decimal :steal_percentage, precision: 3, scale: 1
      t.decimal :block_percentage, precision: 3, scale: 1
      t.decimal :turnover_percentage, precision: 3, scale: 1
      t.decimal :usage_percentage, precision: 3, scale: 1
      t.decimal :offensive_rating, precision: 4, scale: 1
      t.decimal :defensive_rating, precision: 4, scale: 1
      t.integer :plus_minus
      t.timestamps
    end
  end
end
