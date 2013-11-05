class CreateNbaTeams < ActiveRecord::Migration
  def change
    create_table :nba_teams do |t|
      t.string :city
      t.string :name
      t.string :abbr
      t.string :conference
      t.string :division
      t.string :nba_stats_id
      t.string :display_name
      t.timestamps
    end
  end
end
