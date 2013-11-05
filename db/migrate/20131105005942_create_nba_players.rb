class CreateNbaPlayers < ActiveRecord::Migration
  def change
    create_table :nba_players do |t|
      t.belongs_to :nba_team
      t.string :lastname
      t.string :firstname
      t.string :display_name
      t.integer :number
      t.string :position
      t.integer :height
      t.integer :weight
      t.date :birthdate
      t.integer :experience
      t.string :college
      t.timestamps
    end
  end
end
