class PlayersController < ApplicationController
  def index
    @players = Player.all

    # Simple Search (4.1)
    if params[:search].present?
      @players = @players.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # Hierarchical Search (4.2) - Filter by Position
    if params[:position].present?
      @players = @players.where(position: params[:position])
    end
  end
end
