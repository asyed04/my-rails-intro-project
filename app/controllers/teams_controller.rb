class TeamsController < ApplicationController
  def index
    @teams = Team.page(params[:page]).per(10) # Show 10 teams per page
  end

  def show
    @team = Team.find(params[:id])
  end
end
