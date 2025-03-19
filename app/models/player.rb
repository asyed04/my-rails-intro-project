class Player < ApplicationRecord
    has_many :player_transfers
    has_many :teams, through: :player_transfers
end
