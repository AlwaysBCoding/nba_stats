class TeamBoxScoreSerializer < ActiveModel::Serializer
  attributes :opponent,
             :gamedate,
             :location,
             :score,
             :opponent_score,
             :result,
             :q1_points,
             :q2_points,
             :q3_points,
             :q4_points,
             :ot_points,
             :pace,
             :effective_field_goal_percentage,
             :turnover_percentage,
             :offensive_rebound_percentage,
             :free_throw_rate,
             :offensive_rating,
             :box_score_url

  def box_score_url
    nba_matchup_url(object.nba_matchup)
  end

  def opponent
    object.opponent.abbr
  end

  def opponent_score
    object.opponent_box_score.score
  end

end
