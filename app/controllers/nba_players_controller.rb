class NbaPlayersController < ApplicationController

  def show
    @player = NbaPlayer.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @player }
    end
  end

# CONFIG
  def default_serializer_options
    { root: false }
  end

end
