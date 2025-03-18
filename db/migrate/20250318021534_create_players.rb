class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :age
      t.string :position
      t.string :nationality
      t.integer :goals_scored

      t.timestamps
    end
  end
end
