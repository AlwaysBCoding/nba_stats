class NbaTeamSerializer < ActiveModel::Serializer
  attributes :city, :name, :abbr, :display_name, :conference, :division, :url
  has_many :nba_players, key: :roster

  def url
    team_url(object)
  end

end
