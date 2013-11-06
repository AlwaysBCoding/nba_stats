class NbaTeamsController < ApplicationController

  def index
    @teams = NbaTeam.all
  end

  def show
    @team = NbaTeam.find_by_abbr(params[:abbr])
  end

end
