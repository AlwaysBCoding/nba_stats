class PlayerBoxScoresController < ApplicationController

  def show
    @player_box_score = PlayerBoxScore.find(params[:id])
  end

end
