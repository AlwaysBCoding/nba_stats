class NbaTeamsController < ApplicationController

  def index
    @teams = NbaTeam.all
  end

  def show
    @team = NbaTeam.find_by_abbr(params[:abbr].downcase)

    respond_to do |format|
      format.html
      format.json { render json: @team }
    end

  end

# CONFIG
  def default_serializer_options
    { root: false }
  end

end
