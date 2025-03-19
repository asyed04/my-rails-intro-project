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

Faker::UniqueGenerator.clear  # Reset unique tracking before generating data

puts "🌍 Seeding Leagues from CSV..."
CSV.foreach(Rails.root.join('db/leagues.csv'), headers: true) do |row|
    League.create!(
        name: row['name'],
        country: row['country'],
        num_teams: row['num_teams'].to_i,
        latitude: case row['name']
          when "Premier League" then 51.509865
          when "La Liga" then 40.416775
          when "Bundesliga" then 52.520008
          when "Serie A" then 41.902782
          when "Ligue 1" then 48.856613
          when "Eredivisie" then 52.3676
          else Faker::Address.latitude
          end,
        longitude: case row['name']
           when "Premier League" then -0.118092
           when "La Liga" then -3.703790
           when "Bundesliga" then 13.404954
           when "Serie A" then 12.496366
           when "Ligue 1" then 2.352222
           when "Eredivisie" then 4.9041
           else Faker::Address.longitude
           end

      )      
end

puts "🏆 Seeding Teams with Faker..."
League.all.each do |league|
  5.times do
    begin
      Team.create!(
        name: Faker::Sports::Football.team,
        league: league,
        country: league.country,
        founded_year: rand(1900..2020)
      )
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      puts "⚠️ Faker ran out of unique team names, using fallback name."
      Team.create!(
        name: "Generated Team #{rand(1000..9999)}",
        league: league,
        country: league.country,
        founded_year: rand(1900..2020)
      )
    end
  end
end

puts "⚽ Seeding Players from API and Faker..."
Team.all.each do |team|
  puts "Seeding players for #{team.name}..."

  # Assign real players from API
  assigned_api_players = []
  url = URI("https://www.thesportsdb.com/api/v1/json/3/searchplayers.php?t=Barcelona")
  response = Net::HTTP.get(url)
  players_data = JSON.parse(response)["player"]

  players_data.each do |player|
    next if assigned_api_players.include?(player["strPlayer"])

    Player.create!(
      name: player["strPlayer"],
      age: rand(18..40),
      position: player["strPosition"] || "Midfielder",
      nationality: player["strNationality"] || "Unknown",
      goals_scored: rand(0..50),
      teams: [ team ]
    )
    assigned_api_players << player["strPlayer"]
    break if assigned_api_players.length >= 5
  end

  # Ensure 11 players per team
  while team.players.count < 11
    begin
      player_name = Faker::Sports::Football.unique.player
      puts "Assigning Faker Player #{player_name} to #{team.name}..."

      Player.create!(
        name: player_name,
        age: rand(18..40),
        position: [ "Forward", "Midfielder", "Defender", "Goalkeeper" ].sample,
        nationality: Faker::Nation.nationality,
        goals_scored: rand(0..50),
        teams: [ team ]
      )
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      puts "⚠️ Faker ran out of unique player names, using fallback."
      Player.create!(
        name: "Generated Player #{rand(1000..9999)}",
        age: rand(18..40),
        position: [ "Forward", "Midfielder", "Defender", "Goalkeeper" ].sample,
        nationality: "Unknown",
        goals_scored: rand(0..50),
        teams: [ team ]
      )
    end
  end

  puts "✅ Players seeded for #{team.name}!"
end

puts "✅ All teams now have 11 players!"

puts "🔄 Seeding Player Transfers..."
10.times do
  PlayerTransfer.create!(
    player: Player.order("RANDOM()").first,
    team: Team.order("RANDOM()").first,
    transfer_date: Faker::Date.between(from: '2020-01-01', to: '2024-01-01')
  )
end

puts "✅ Seeding Complete!"
