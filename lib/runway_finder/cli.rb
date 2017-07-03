# Our CLI Controller

class RunwayFinder::CLI

  def call
    menu
  end

  def menu

    input = ""
    while input != "exit"

      puts "Please enter the zip code you would like to search for airports, or exit to quit:"
      input = gets.strip
      # For future, check if input is a valid zipcode

      if input != "exit"

        RunwayFinder::Airport.find_airports_by_zipcode( input )

        puts "Enter the three character code (i.e. ORD) for the airport you want to learn more about, or 'exit' to quit:"
        detail_input = gets.strip.upcase
        while detail_input != "exit" && detail_input != "EXIT"
          # Make sure the code is one from the list
          if RunwayFinder::Airport.check_code( detail_input )
            RunwayFinder::Runway.find_runway_details( detail_input )
            detail_input = "exit"
          else
            puts "******************************************************"
            puts "Could not find details for airport code '#{detail_input}'."
            puts "Please enter a code from the list."
            puts "******************************************************"
            RunwayFinder::Airport.display_airport_list
            puts "Enter a three character code (i.e. ORD) from the list for the airport you want to learn more about, or 'exit' to quit:"
            detail_input = gets.strip.upcase
          end
        end

      else
        goodbye
      end

      RunwayFinder::Airport.reset
      RunwayFinder::Runway.reset
    end # while

  end # menu

  def goodbye
    puts"Thank you for using Runway Finder."
  end

end  #class RunwayFinder::CLI
