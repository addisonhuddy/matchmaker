class TeamsController < ApplicationController

  def index
    @teams = Team.all
    @students = Student.all
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      p "Team created"
    else
      p "Team failed to create"
    end
  end

  def match_teams
    if Team.match_teams_by_hour == 0
      flash[:success] = "Teams Matched Successfully"
      redirect_to teams_path
    end

  end

  private

  def team_params
      params.require(:team).permit(:name, :common_hours)
  end
end
