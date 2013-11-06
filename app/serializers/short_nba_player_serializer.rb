class ShortNbaPlayerSerializer < ActiveModel::Serializer
  attributes :lastname, :firstname, :display_name, :number, :position, :height, :weight, :birthdate, :experience, :college, :url

  def url
    player_url(object)
  end

end
