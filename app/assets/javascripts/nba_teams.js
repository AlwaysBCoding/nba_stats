$(function() {

  // NBA TEAMS SHOW
  if ($("body.nba_teams-show").length > 0) {
    var team = $(".team-information").data("team");
    var roster_urls = [];
    var roster = [];
    var leadingScorers = [];
    var leadingRebounders = [];

    $.getJSON("/team/" + team + ".json", function(data) {
      _.each(data.roster, function(player) {
        roster_urls.push(player.url + ".json");
      });

      _.each(roster_urls, function(url, index) {
        $.getJSON(url, function(data) {
          roster.push(data);
          if (index + 1 == roster_urls.length) {
            generateLeadingScorers(roster);
            generateLeadingRebounders(roster);
            displayLeadingScorers(leadingScorers);
            displayLeadingRebounders(leadingRebounders);
          };
        });
      });
    });

  var generateLeadingScorers = function(roster) {
    _.each(roster, function(player) {
      if (calculatePointsPerGame(player) > 1) {
        leadingScorers.push({"name": player.display_name, "ppg": calculatePointsPerGame(player) });
      }
    });
  }

  var generateLeadingRebounders = function(roster) {
    _.each(roster, function(player) {
      if (calculateReboundsPerGame(player) > 1) {
        leadingRebounders.push({"name": player.display_name, "ppg": calculateReboundsPerGame(player) });
      }
    });
  }

  var calculatePointsPerGame = function(player) {
    var totalPoints = player.total_stats.points;
    var gamesPlayed = player.total_stats.games_played;
    if (gamesPlayed > 0) {
      return (totalPoints / gamesPlayed).toFixed(2);
    } else {
      return 0;
    }
  }

  var calculateReboundsPerGame = function(player) {
    var totalRebounds = player.total_stats.total_rebounds;
    var gamesPlayed = player.total_stats.games_played;
    if (gamesPlayed > 0) {
      return (totalRebounds / gamesPlayed).toFixed(2);
    } else {
      return 0;
    }
  }

  var displayLeadingScorers = function(leadingScorers) {
    $($(".ajax-loading")[0]).hide();

    var target = d3.select(".leading-scorers");
    target.selectAll("div")
          .data(leadingScorers)
          .enter().append("div")
          .style("width", "300px")
          .transition().duration(2000)
          .style("width", function(d) { return ((d.ppg * 40 + "px")) })
          .text(function(d) { return d.name });
  }

  var displayLeadingRebounders = function(leadingRebounders) {
    $($(".ajax-loading")[1]).hide();

    var target = d3.select(".leading-rebounders");
    target.selectAll("div")
          .data(leadingRebounders)
          .enter().append("div")
          .style("width", "300px")
          .transition().duration(2000)
          .style("width", function(d) { return ((d.ppg * 80 + "px")) })
          .text(function(d) { return d.name });
  }

  }; // NBA TEAMS SHOW

});
