namespace :seed_data do
  desc "Goes through the rosters scraped from NBA.com and adjusts the player names that have inconsistencies with basketball-reference"
  task :fix_inconsistent_player_names => :environment do

    inconsistent_names = []

    inconsistent_names << ["CJ Miles", "C.J. Miles", "cle"]
    inconsistent_names << ["Gigi Datome", "Luigi Datome", "det"]
    inconsistent_names << ["CJ Watson", "C.J. Watson", "ind"]
    inconsistent_names << ["Roger Mason Jr.", "Roger Mason", "mia"]
    inconsistent_names << ["Timothy Hardaway Jr.", "Tim Hardaway", "nyk"]
    inconsistent_names << ["Nene", "Nene Hilario", "was"]
    inconsistent_names << ["JJ Hickson", "J.J. Hickson", "den"]
    inconsistent_names << ["Ognen Kuzmic", "Ognjen Kuzmic", "gsw"]
    inconsistent_names << ["JJ Redick", "J.J. Redick", "lac"]
    inconsistent_names << ["Jose Juan Barea", "Jose Barea", "min"]

    inconsistent_names.each do |name_data|
      player = NbaPlayer.find_by_display_name(name_data[0])
      if player.present?
        player.update_attributes(display_name: name_data[1])
        puts "UPDATED #{name_data[0]} => #{name_data[1]} : #{name_data[2].upcase}"
      else
        puts "COULD NOT FIND player #{name_data[0]} : #{name_data[2].upcase}"
      end
    end

  end
end
