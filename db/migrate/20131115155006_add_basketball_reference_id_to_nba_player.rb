class AddBasketballReferenceIdToNbaPlayer < ActiveRecord::Migration
  def change
    add_column :nba_players, :basketball_reference_id, :string
  end
end
