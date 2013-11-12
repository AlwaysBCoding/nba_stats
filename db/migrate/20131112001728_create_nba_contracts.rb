class CreateNbaContracts < ActiveRecord::Migration
  def change
    create_table :nba_contracts do |t|
      t.belongs_to :nba_player
      t.integer :salary_2014, default: 0
      t.integer :salary_2015, default: 0
      t.integer :salary_2016, default: 0
      t.integer :salary_2017, default: 0
      t.integer :salary_2018, default: 0
      t.integer :salary_2019, default: 0
      t.integer :salary_2020, default: 0

      t.timestamps
    end
  end
end
