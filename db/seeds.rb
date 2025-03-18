# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'csv'
require 'net/http'
require 'json'

# Clear existing data
PlayerTransfer.destroy_all
Player.destroy_all
Team.destroy_all
League.destroy_all

puts "🌍 Seeding Leagues from CSV..."
CSV.foreach(Rails.root.join('db/leagues.csv'), headers: true) do |row|
  League.create!(
    name: row['name'],
    country: row['country'],
    num_teams: row['num_teams'].to_i
  )
end

puts "🏆 Seeding Teams with Faker..."
League.all.each do |league|
  5.times do
    Team.create!(
      name: Faker::Sports::Football.team,
      league: league,
      country: league.country,
      founded_year: rand(1900..2020)
    )
  end
end

puts "⚽ Seeding Players from API..."
url = URI("https://www.thesportsdb.com/api/v1/json/3/searchplayers.php?t=Barcelona")
response = Net::HTTP.get(url)
players_data = JSON.parse(response)["player"]

players_data.first(10).each do |player|
  team = Team.order("RANDOM()").first
  Player.create!(
    name: player["strPlayer"],
    age: rand(18..40),
    position: player["strPosition"] || "Midfielder",
    nationality: player["strNationality"] || "Unknown",
    goals_scored: rand(0..50),
    teams: [team]
  )
end

puts "🔄 Seeding Player Transfers..."
10.times do
  PlayerTransfer.create!(
    player: Player.order("RANDOM()").first,
    team: Team.order("RANDOM()").first,
    transfer_date: Faker::Date.between(from: '2020-01-01', to: '2024-01-01')
  )
end

puts "✅ Seeding Complete!"
