class CreateLeagues < ActiveRecord::Migration[8.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :country
      t.integer :num_teams

      t.timestamps
    end
  end
end
