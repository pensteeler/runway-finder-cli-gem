class RunwayFinder::Airport

  @@all = []

  attr_accessor :name, :code, :distance, :url, :runway, :url_with_zip


  def self.nearby( zip_code )

    puts "Searching for airports near the #{zip_code} zip code."
    #https://landingfinder.com/index.php?address=60005
    #self.send("#{k}=", v)

    @url_with_zip = ""
    @url_with_zip = "https://landingfinder.com/index.php?address=#{zip_code}"
    #puts "URL:#{url_with_zip}"
    #airports = scrape_by_zipcode( url_with_zip )
    airports = scrape_by_zipcode

    display_list( airports )

  end

  def self.display_list( airports )

    if airports != nil
      puts "These airports are near by:"
      puts "#    Code    Name and Distance"
      puts "***  *****   ***********************************"
      airports.each do |a|
        puts "#{a[:number]}.   (#{a[:code]})   #{a[:name]} is #{a[:distance]} miles away."
        #  puts "#{v}"
      end
    else
      puts "There are no airports near that zip code."
    end

  end

  def self.display_details( runways )

    if runways != nil
      puts "Has the folowing runways."
      puts "Number  Length  Width  Type   Condition"
      puts "******  ******  *****  ****   *********"
      runways.each do |r|
        puts "#{r[:number]}  #{r[:length]}  #{r[:width]}  #{r[:type]} #{r[:condition]}"
      end
    else
      puts "Cannot find any runways for that airport."
    end

  end

  def self.scrape_by_zipcode

    airports = []

    doc = Nokogiri::HTML( open(@url_with_zip) )

    all = doc.css("div#list tr")
    #puts "\n*************************"
    #puts "All:#{all}"
    #puts "***********  After ALL **************\n"
    # This has all the codes together
    #code = doc.css(".loaddetails")[0].text

    doc.css("div#list tr").each_with_index do |row,i|
      #puts "\n** i:#{i} **\n"
      if i > 0 && row.css("td")[0].text != "" && i < 20
        #puts "\nRow: #{row}:**END OF ROW**"
        number = row.css("td")[0].text

        code = row.css("td")[1].text
        code_link = doc.css(".loaddetails").text
        distance = row.css("td")[2].text
        name = row.css("td")[3].text

        #puts "Number:#{number}"
        #puts "Code is:#{code}"
        #puts "Distance:#{distance}"
        #puts "Name:#{name}"

        airports << { number: number, code: code, distance: distance, name: name }
      end # if
    end #doc.css("div#list tr").each_with_index do |row,i|

    #puts airports
    #codeLink = doc.css(".loaddetails").text
    #distance = doc.css("div#list td")[2].text

    # Site will display "Sorry, we could not find any suitable airports for this address!"
    #      if the zip code is not "valid"

    airports
  end # scrape_by_zipcode

  def self.show_details( airport_code)
    puts "Showing more info for airport: #{airport_code}"

    runway_details = scrape_by_code( airport_code )
    display_details( runway_details )

  end

  def self.scrape_by_code( airport_code )

    runways = []

    puts "Searching for details for #{airport_code}"
    url_with_code = "https://flightaware.com/resources/airport/#{airport_code}/summary"
    #url_with_code = "http://www.airnav.com/airport/#{airport_code}"
    #puts "checking site:#{url_with_code}"
    doc = Nokogiri::HTML( open(url_with_code) )

    #runway_number = doc.css("h4:nth-of-type(3)")
    runway_number = doc.css("div.medium-2.columns tr")
    #puts "\n*************************"
    #puts "All:#{runway_number.text}"
    #puts "***********  After ALL runway numbers **************\n"

    runway_number.each_with_index do |r, i|
      #puts "Row:(#{i}).#{r}"
      #puts "Checking first cell:#{r.css("td")[0]}"
      if r.css("td")[0].to_s.include?("href")
        #puts "******   Adding  ********"
        #puts "Number:#{r.css("td")[0].text}"
        #puts "Length:#{r.css("td")[1].text}"
        #puts "Width:#{r.css("td")[2].text}"
        #puts "Type:#{r.css("td")[3].text}"
        #puts "Condition:#{r.css("td")[4].text}"

        number = r.css("td")[0].text
        length = r.css("td")[1].text
        width = r.css("td")[2].text
        type = r.css("td")[3].text
        condition = r.css("td")[4].text

        runways << {number: number, length: length, width: width, type: type, condition: condition}
      end
      #puts runways
      #runways
    end

    runways
  end # scrape_by_code

end #class RunwayFinder::Airport
