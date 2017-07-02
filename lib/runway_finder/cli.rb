# Our CLI Controller

class RunwayFinder::CLI

  def call

    menu

  end

  def build_list( zip_code )
    #puts "1. O'Hare"
    #puts "2. Lake in the Hills"
    #puts "3. Executive"

    @airports = RunwayFinder::Airport.nearby(zip_code)
    #@airports.each.with_index(1) do |airport, i|
    #  puts "#{i}. #{airport.name}  Code:#{airport.code} Distance:#{airport.distance}"
    #end

  end

  def menu
    input = ""
    while input != "exit"
      puts "Please enter the zip code you would like to search for airports, or exit to quit:"
      input = gets.strip

      if input != "exit"
        # Check if input is 5 chars
        zip_code = input
        build_list( zip_code )

        puts "Enter the three character code (i.e. ORD) for the airport you want to learn more about:"
        airportCode = gets.strip.upcase
        if input != "exit"
          RunwayFinder::Airport.show_details( airportCode )
        end
      else
        goodbye
      end
    end

  end

  def goodbye
    puts"Thank you for using Runway Finder."
  end

end  #class RunwayFinder::CLI
