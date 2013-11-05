class CreateTeamBoxScores < ActiveRecord::Migration
  def change
    create_table :team_box_scores do |t|
      t.belongs_to :nba_matchup
      t.belongs_to :nba_team
      t.string :location
      t.integer :q1_points
      t.integer :q2_points
      t.integer :q3_points
      t.integer :q4_points
      t.integer :ot_points
      t.integer :score
      t.string :result
      t.decimal :pace, precision: 4, scale: 1
      t.decimal :effective_field_goal_percentage, precision: 4, scale: 3
      t.decimal :turnover_percentage, precision: 3, scale: 1
      t.decimal :offensive_rebound_percentage, precision: 3, scale: 1
      t.decimal :free_throw_rate, precision: 4, scale: 3
      t.decimal :offensive_rating, precision: 4, scale: 1
      t.timestamps
    end
  end
end
