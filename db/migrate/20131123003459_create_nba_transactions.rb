class CreateNbaTransactions < ActiveRecord::Migration
  def change
    create_table :nba_transactions do |t|
      t.date :transaction_date
      t.text :description
    end
  end
end
