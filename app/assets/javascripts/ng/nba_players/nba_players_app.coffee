# initialize app
nbaPlayersApp = angular.module "nbaPlayers", []

# factories
nbaPlayersApp.factory "playersApiFactory", ["$http", ($http) ->
  playersApiFactory = {}

  playersApiFactory.getPlayers = ->
    players = []

    $http
      method: "GET"
      url: "/players.json"
    .success (data, status, headers, config) ->
      _.each data, (dirty_player) ->
        clean_player = {}
        clean_player.display_name = dirty_player.display_name
        clean_player.team = dirty_player.team.toUpperCase()
        clean_player.minutes_per_game = parseFloat(dirty_player.minutes_per_game)
        clean_player.points_per_game = parseFloat(dirty_player.points_per_game)
        clean_player.assists_per_game = parseFloat(dirty_player.assists_per_game)
        clean_player.offensive_rebounds_per_game = parseFloat(dirty_player.offensive_rebounds_per_game)
        clean_player.defensive_rebounds_per_game = parseFloat(dirty_player.defensive_rebounds_per_game)
        clean_player.total_rebounds_per_game = parseFloat(dirty_player.total_rebounds_per_game)
        clean_player.steals_per_game = parseFloat(dirty_player.steals_per_game)
        clean_player.blocks_per_game = parseFloat(dirty_player.blocks_per_game)
        clean_player.turnovers_per_game = parseFloat(dirty_player.turnovers_per_game)
        clean_player.college = dirty_player.college
        clean_player.position = dirty_player.position
        clean_player.height = dirty_player.height
        players.push(clean_player)

    return players

  return playersApiFactory
]

# controllers
nbaPlayersApp.controller "nbaPlayersController", ["$scope", "$filter", "playersApiFactory", ($scope, $filter, playersApiFactory) ->

  $scope.heading = "League Leaders"
  $scope.sortProperty = "points_per_game"
  $scope.sortDirection = true
  $scope.players = playersApiFactory.getPlayers()

  $scope.sortBy = (column) ->
    if $scope.sortProperty == column
      $scope.sortDirection = !$scope.sortDirection
    else
      $scope.sortProperty = column
      $scope.sortDirection = true
]

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

# directives

# app.directive "firstplayer", ->
#   {
#     restrict: "E"
#     template: "Name: {{players[0].display_name}}"
#   }
