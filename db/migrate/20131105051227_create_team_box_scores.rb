class CreateTeamBoxScores < ActiveRecord::Migration
  def change
    create_table :team_box_scores do |t|
      t.belongs_to :nba_matchup
      t.belongs_to :nba_team
      t.string :location
      t.integer :q1_pts
      t.integer :q2_pts
      t.integer :q3_pts
      t.integer :q4_pts
      t.integer :score
      t.string :result
      t.integer :pace
      t.timestamps
    end
  end
end
