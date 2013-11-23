class SearchController < ApplicationController

  def index
  end

  def query
    index = ""
    filters, filter_seperators = [], []

    query_string = params[:q]

    amulets = query_string.scan(/\s?SEARCH\s|\sFILTER\s|\sOR\s|\sAND\s/).map { |amulet| amulet.strip! }
    tokens  = query_string.split(/\s?SEARCH\s|\sFILTER\s|\sOR\s|\sAND\s/)
    tokens.shift

    query_array = []
    amulets.each_with_index do |amulet, index|
      query_array.push({ amulet: amulet, token: tokens[index] })
    end

    query_array.each do |coupling|
      amulet, token = coupling[:amulet], coupling[:token]

      if amulet == "SEARCH"
        index = token
      end

      if amulet == "FILTER"
        emerald = token.scan(/\s=\s|\s>\s|\s<\s|\s>=\s|\s<=\s/).map { |emerald| emerald.strip! }.first.strip
        filter, value = token.split(emerald)[0].strip, token.split(emerald)[1].strip

        filters << {
          type: filter.split(".")[0],
          field: filter.split(".")[1],
          value: value,
          emerald: emerald
        }
      end

      if (amulet == "OR" || amulet == "AND")
      end

      # if amulet == "SAME"
      # end

    end

    # raise filters.inspect

    type = "player"
    # filters = ["points >= 40", "assists >= 20"]
    # filter_seperators = ["OR"]

    filters = ["points >= 40"]

    query_segment = filters.zip(filter_seperators).flatten.compact.join(" ")

    response = PlayerBoxScore.where(query_segment)
    render json: response
  end

end
