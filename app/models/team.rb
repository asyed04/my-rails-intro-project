class Team < ApplicationRecord
  belongs_to :league
  has_many :player_transfers
  has_many :players, through: :player_transfers
end
