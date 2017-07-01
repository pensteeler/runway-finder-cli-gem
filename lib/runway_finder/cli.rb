# Our CLI Controller

class RunwayFinder::CLI

  def call
    puts "Hello Hickory"
    #list_runways
    menu
    goodbye

  end

  def list_runways
    puts "1. O'Hare"
    puts "2. Lake in the Hills"
    puts "3. Executive"
  end

  def menu
    input = ""
    while input != "exit"
      puts "Please enter the zip code you would like to search for airports, or exit to quit:"
      input = gets.strip

      if input != "exit"
        zip_code = input
        puts "Searching Zip Code:#{zip_code}"
        list_runways

        puts "Enter the number of the airport you want to learn more about:"
        input = gets.strip.downcase
        puts "Showing more info for airport number #{input}"
      end
    end

  end

  def goodbye
    puts"Thank you for using Runway Finder."
  end

end  #class RunwayFinder::CLI
