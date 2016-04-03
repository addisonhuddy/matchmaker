class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      p "Team created"
    else
      p "Team failed to create"
    end
  end

  private

  def team_params
      params.require(:team).permit(:name, :common_hours)
  end
end
