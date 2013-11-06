class PlayerBoxScoreSerializer < ActiveModel::Serializer
  attributes :opponent,
             :gamedate,
             :location,
             :result,
             :seconds_played,
             :field_goals_made,
             :field_goals_attempted,
             :three_pointers_made,
             :three_pointers_attempted,
             :free_throws_made,
             :free_throws_attempted,
             :offensive_rebounds,
             :defensive_rebounds,
             :assists,
             :steals,
             :blocks,
             :turnovers,
             :personal_fouls,
             :points,
             :true_shooting_percentage,
             :effective_field_goal_percentage,
             :offensive_rebound_percentage,
             :assist_percentage,
             :steal_percentage,
             :block_percentage,
             :turnover_percentage,
             :usage_percentage,
             :offensive_rating,
             :defensive_rating,
             :plus_minus,
             :box_score_url

  def opponent
    object.opponent.abbr
  end

  def box_score_url
    nba_matchup_url(object.nba_matchup)
  end

end
