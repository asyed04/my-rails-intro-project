class CreatePlayerTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :player_transfers do |t|
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.date :transfer_date

      t.timestamps
    end
  end
end
