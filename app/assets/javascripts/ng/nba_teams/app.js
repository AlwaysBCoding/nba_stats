// Generated by CoffeeScript 1.6.3
var app;

app = angular.module("nbaTeams", []);

app.factory("teamsApiFactory", [
  "$http", function($http) {
    var teamsApiFactory;
    teamsApiFactory = {};
    teamsApiFactory.getTeams = function() {
      var teams;
      teams = [];
      $http({
        method: "GET",
        url: "/teams.json"
      }).success(function(data, status, headers, config) {
        return _.each(data, function(team) {
          return teams.push(team);
        });
      });
      return teams;
    };
    return teamsApiFactory;
  }
]);

app.controller("nbaTeamsController", ["$scope", "teamsApiFactory", function($scope, teamsApiFactory) {}]);
