class PlayersController < ApplicationController
  def index
    @players = Player.all

    # Simple Search (4.1)
    if params[:search].present?
      @players = @players.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%")
    end

    # Hierarchical Search (4.2) - Filter by Position
    if params[:position].present?
      @players = @players.where(position: params[:position])
    end
  end

  # Fix for "undefined method 'name' for nil"
  def show
    @player = Player.find_by(id: params[:id])

    if @player.nil?
      flash[:alert] = "Player not found!"
      redirect_to players_path  # Redirect to players list if not found
    end
  end
end
