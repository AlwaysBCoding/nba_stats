class CreatePlayerBoxScores < ActiveRecord::Migration
  def change
    create_table :player_box_scores do |t|
      t.belongs_to :nba_player
      t.belongs_to :nba_matchup
      t.string :location
      t.integer :seconds
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
      t.integer :offensive_rating
      t.integer :defensive_rating
      t.timestamps
    end
  end
end
