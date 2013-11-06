class NbaPlayersController < ApplicationController

  def show
    @player = NbaPlayer.find(params[:id])
  end

end
