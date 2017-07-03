class RunwayFinder::Runway

  @@all = []

  attr_accessor :airport_code, :number, :length, :width, :type, :condition

  def initialize( airport_code )
    @airport_code = airport_code
  end

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end

  def self.find_runway_details( airport_code )
    if scrape_by_code( airport_code )
      display_runway_details
    else
      puts "Could not find any runways for airport code #{airport_code}."
    end

  end


  def self.scrape_by_code( airport_code )

    #runways = []

    puts "Searching for details for #{airport_code}"
    url_with_code = "http://flightaware.com/resources/airport/K#{airport_code}/summary"
    doc = Nokogiri::HTML( open(url_with_code) )
    if doc
    runways = doc.css("div.medium-2.columns tr")

    runways.each_with_index do |r, i|
      if r.css("td")[0].to_s.include?("href")
        runway = RunwayFinder::Runway.new( airport_code )
        runway.number = r.css("td")[0].text
        runway.length = r.css("td")[1].text
        runway.width = r.css("td")[2].text
        runway.type = r.css("td")[3].text
        runway.condition = r.css("td")[4].text

        #runways << {number: number, length: length, width: width, type: type, condition: condition}
        @@all << runway
      end

      runway
    end

    end
  end # scrape_by_code

  def self.display_runway_details

    if @@all != nil
      puts "Has the folowing runways."
      puts "Number     Length    Width    Type       Condition"
      puts "******  *********  *******    *******    *********"
      self.all.each do |r|
        #puts "#{r[:number]}  #{r[:length]}  #{r[:width]}  #{r[:type]} #{r[:condition]}"
        printf("%-8s %8s %8s    %-8s   %-10s%\n", "#{r.number}", "#{r.length}", "#{r.width}", "#{r.type}", "#{r.condition}")

        #{}"  #{r[:width]}  #{r[:type]} #{r[:condition]})
      end
    else
      puts "Cannot find any runways for that airport (#{@airport_code})."
    end

  end # display_runway_details

end # class RunwayFinder::Runway
