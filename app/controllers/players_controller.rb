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

    # ✅ Add Kaminari pagination (shows 10 players per page)
    @players = @players.page(params[:page]).per(10)
  end

  def show
    @player = Player.find_by(id: params[:id])
    if @player.nil?
      flash[:alert] = "Player not found!"
      redirect_to players_path
    end
  end
end
