class CreateNbaMatchups < ActiveRecord::Migration
  def change
    create_table :nba_matchups do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.string :basketball_reference_id
      t.string :referees, array: true, default: []
      t.date :gamedate
      t.timestamps
    end
  end
end
