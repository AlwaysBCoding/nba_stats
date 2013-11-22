$ ->

# HELPER METHODS
  format_pbx = (pbx) ->
    display_location = if pbx.location == "home" then "vs." else "@"
    response  = "<li class='query-response'>"
    response +=   "<a class='bsaketball-reference-link' href='http://www.basketball-reference.com/boxscores/#{pbx.basketball_reference_id}.html' target='blank'>"
    response +=     "#{pbx.player} #{pbx.points} points #{display_location} #{pbx.opponent.toUpperCase()} on #{pbx.gamedate}"
    response +=    "</a>"
    response += "</li>"
    return response

# JQUERY DOM SECTIONS
  search_response_container = $(".search-response-container ul")

# EVENT HANDLERS
  $(".search-form").on "submit", (e) ->
    e.preventDefault()
    search_response_container.html("")
    query = $(this).find(".search-query").val()

    $.ajax
      method: "GET"
      url: "/query?q=#{query}"
      success: (data) ->
        sorted_results = _.sortBy data.search, (pbx) ->
          pbx.points
        _.each sorted_results, (pbx) ->
          search_response_container.append format_pbx(pbx)
