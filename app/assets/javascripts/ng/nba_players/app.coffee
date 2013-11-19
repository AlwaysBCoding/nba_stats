app = angular.module "nba_players", []

app.controller "nba_players_controller", ($scope, $http, $filter) ->
  $scope.heading = "League Leaders"

  $http
    method: "GET"
    url: "../players.json"
  .success (data, status, headers, config) ->
    _.each data, (player) ->
      player.team = player.team.toUpperCase()
      player.minutes_per_game = parseFloat(player.minutes_per_game)
      player.points_per_game = parseFloat(player.points_per_game)
      player.assists_per_game = parseFloat(player.assists_per_game)
      player.offensive_rebounds_per_game = parseFloat(player.offensive_rebounds_per_game)
      player.defensive_rebounds_per_game = parseFloat(player.defensive_rebounds_per_game)
      player.total_rebounds_per_game = parseFloat(player.total_rebounds_per_game)
      player.steals_per_game = parseFloat(player.steals_per_game)
      player.blocks_per_game = parseFloat(player.blocks_per_game)
      player.turnovers_per_game = parseFloat(player.turnovers_per_game)

      $scope.players = data

  $scope.sortProperty = "points_per_game"
  $scope.sortDirection = true

  $scope.sortBy = (column) ->

    if $scope.sortProperty == column
      $scope.sortDirection = !$scope.sortDirection
    else
      $scope.sortProperty = column
      $scope.sortDirection = true

    # ordered_players = $filter('orderBy')($scope.players, $scope.sortProperty, $scope.sortDirection)
    # featured_players = $filter('limitTo')(ordered_players, 5)

    # target = d3.select(".featured-players")
    # target
    #   .selectAll("div")
    #   .data($scope.players)
    #   .enter()
    #   .append("circle")
    #   .attr "cx", (d) ->
    #     d.minutes_per_game * 20
    #   .attr "cy", (d) ->
    #     500 - (d[column] * 11)
    #   .attr("r", 5)
    #   .on "click", (player) ->
    #     $scope.selectedPlayer = player.display_name

# app.directive "firstplayer", ->
#   {
#     restrict: "E"
#     template: "Name: {{players[0].display_name}}"
#   }
