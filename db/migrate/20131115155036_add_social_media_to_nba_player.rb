class AddSocialMediaToNbaPlayer < ActiveRecord::Migration
  def change
    add_column :nba_players, :twitter, :string
    add_column :nba_players, :instagram, :string
  end
end
