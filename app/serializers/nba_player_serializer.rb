class NbaPlayerSerializer < ActiveModel::Serializer
  attributes :lastname, :firstname, :display_name, :number, :position, :height, :weight, :birthdate, :experience, :college, :url, :total_stats
  has_many :player_box_scores, key: :box_scores

  def url
    player_url(object)
  end

  def total_stats
    {
      seconds_played: object.sum_stat_total(:seconds_played),
      games_played: object.games_played.to_i,
      field_goals_made: object.sum_stat_total(:field_goals_made),
      field_goals_attempted: object.sum_stat_total(:field_goals_attempted),
      field_goal_percentage: (object.sum_stat_percentage(:field_goals_made, :field_goals_attempted) * 100).round(2),
      three_pointers_made: object.sum_stat_total(:three_pointers_made),
      three_pointers_attempted: object.sum_stat_total(:three_pointers_attempted),
      three_point_percentage: (object.sum_stat_percentage(:three_pointers_made, :three_pointers_attempted) * 100).round(2),
      free_throws_made: object.sum_stat_total(:free_throws_made),
      free_throws_attempted: object.sum_stat_total(:free_throws_attempted),
      free_throw_percentage: (object.sum_stat_percentage(:free_throws_made, :free_throws_attempted) * 100).round(2),
      offensive_rebounds: object.sum_stat_total(:offensive_rebounds),
      defensive_rebounds: object.sum_stat_total(:defensive_rebounds),
      total_rebounds: object.sum_stat_total(:offensive_rebounds) + object.sum_stat_total(:defensive_rebounds),
      assists: object.sum_stat_total(:assists),
      steals: object.sum_stat_total(:steals),
      blocks: object.sum_stat_total(:blocks),
      turnovers: object.sum_stat_total(:turnovers),
      personal_fouls: object.sum_stat_total(:personal_fouls),
      points: object.sum_stat_total(:points)
    }
  end

end
