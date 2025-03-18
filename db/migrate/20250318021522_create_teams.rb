class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :league, null: false, foreign_key: true
      t.string :country
      t.integer :founded_year

      t.timestamps
    end
  end
end
