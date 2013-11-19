$(function() {

  // NBA TEAMS SHOW
  if ($("body.nba_teams-show").length > 0) {
    var team = $(".team-information").data("team");
    var roster_urls = [];
    var roster = [];
    var leadingScorers = [];

    $.getJSON("http://localhost:4000/team/" + team + ".json", function(data) {
      _.each(data.roster, function(player) {
        roster_urls.push(player.url + ".json");
      });

      _.each(roster_urls, function(url, index) {
        $.getJSON(url, function(data) {
          roster.push(data);
          if (index + 1 == roster_urls.length) {
            generateLeadingScorers(roster)
            displayLeadingScorers(leadingScorers);
          };
        });
      });
    });

  var generateLeadingScorers = function(roster) {
    _.each(roster, function(player) {
      if (calculatePointsPerGame(player) > 5) {
        leadingScorers.push({"name": player.display_name, "ppg": calculatePointsPerGame(player) });
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

  var displayLeadingScorers = function(leadingScorers) {
    $(".ajax-loading").hide();
    var target = d3.select(".leading-scorers");
    target.selectAll("div")
          .data(leadingScorers)
          .enter().append("div")
          .style("width", "300px")
          .transition().duration(2000)
          .style("width", function(d) { return ((d.ppg * 40 + "px")) })
          .text(function(d) { return d.name });
  }

  }; // NBA TEAMS SHOW

});
