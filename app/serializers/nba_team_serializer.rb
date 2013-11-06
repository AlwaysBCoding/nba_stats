class NbaTeamSerializer < ActiveModel::Serializer
  attributes :city, :name, :abbr, :display_name, :conference, :division, :url
  has_many :nba_players, key: :roster, serializer: ShortNbaPlayerSerializer
  has_many :team_box_scores, key: :box_scores

  def url
    team_url(object)
  end

end
