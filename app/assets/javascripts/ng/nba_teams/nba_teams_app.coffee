# initialize app
app = angular.module "nbaTeams", []

# factories
app.factory "teamsApiFactory", ["$http", ($http) ->
  teamsApiFactory = {}

  teamsApiFactory.getTeams = ->
    teams = []

    $http
      method: "GET"
      url: "/teams.json"
    .success (data, status, headers, config) ->
      _.each data, (team) ->
        teams.push(team)

    return teams

  return teamsApiFactory
]

# controllers
app.controller "nbaTeamsController", [ "$scope", "teamsApiFactory", ($scope, teamsApiFactory) ->

  $scope.teams = teamsApiFactory.getTeams()
  $scope.sortProperty = "net_rating"
  $scope.sortDirection = true

  $scope.sortBy = (column) ->
    if $scope.sortProperty == column
      $scope.sortDirection = !$scope.sortDirection
    else
      $scope.sortProperty = column
      $scope.sortDirection = true
]
