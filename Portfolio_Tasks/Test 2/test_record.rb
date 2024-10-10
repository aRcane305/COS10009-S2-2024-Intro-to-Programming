

require_relative 'yacht'

def main()
    ship = Ship.new
    ship.name = "Omen"
    ship.hull = Hull::Round
    ship.construction = "wood"
    ship.rig = Rig::Gaff

    puts "#{ship.name}"
    puts Hull_names[ship.hull]
    puts "#{ship.construction}"
    puts Rig_names[ship.rig]
end

main()