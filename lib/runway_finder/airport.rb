class RunwayFinder::Airport

  @@all = []

  attr_accessor :number, :name, :code, :distance, :url, :runway, :url_with_zip

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end

  def self.find_airports_by_zipcode( zip_code )

    puts ".........  Searching for airports near the #{zip_code} zip code."
    #https://landingfinder.com/index.php?address=60005
    #self.send("#{k}=", v)

    @url_with_zip = ""
    @url_with_zip = "https://landingfinder.com/index.php?address=#{zip_code}"
    #puts "URL:#{url_with_zip}"
    #airports = scrape_by_zipcode( url_with_zip )
    #airports = scrape_by_zipcode
    scrape_by_zipcode
    display_airport_list

  end

  def self.scrape_by_zipcode

    #airports = []

    doc = Nokogiri::HTML( open(@url_with_zip) )

    doc.css("div#list tr").each_with_index do |row,i|

      if i > 0 && row.css("td")[0].text != "" && i < 20
        airport = RunwayFinder::Airport.new

        airport.number = row.css("td")[0].text
        airport.code = row.css("td")[1].text
        #airport.code_link = doc.css(".loaddetails").text
        airport.distance = row.css("td")[2].text
        airport.name = row.css("td")[3].text

        @@all << airport
      end # if

    end #doc.css("div#list tr").each_with_index do |row,i|

  end # scrape_by_zipcode

  def self.display_airport_list

    if self.all != nil
      puts "These airports are near by:"
      puts "   #     Code    Name and Distance"
      puts " *****   *****   ***********************************"
      self.all.each do |a|
        printf("%5s.   (%3s)   #{a.name} is #{a.distance} miles away.\n", "#{a.number}", "#{a.code}" )
        #  puts "#{v}"
      end
    else
      puts "There are no airports near that zip code."
    end

  end  # display_airport_list

  def self.check_code( airport_code )
    #puts "Validating airport code #{airport_code}."
    self.all.detect { |a| a.code == airport_code }
  end

end #class RunwayFinder::Airport
