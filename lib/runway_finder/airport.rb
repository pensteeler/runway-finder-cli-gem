class RunwayFinder::Airport

  @@all = []

  attr_accessor :name, :code, :distance, :url, :runway

  def self.nearby( zip_code )

    puts "Searching for airports near the #{zip_code} zip code."
    #https://landingfinder.com/index.php?address=60005
    #self.send("#{k}=", v)

    url_with_zip = ""
    url_with_zip = "https://landingfinder.com/index.php?address=#{zip_code}"
    #puts "URL:#{url_with_zip}"
    airports = scrape_by_zipcode( url_with_zip )

    display_list( airports )

    # maybe add link to actual runway numbers/length condition, etc...
    # it would be a Runway objects
    #airport_1.runway
  end

  def self.display_list( airports )

    puts "These are near by:"
    airports.each do |a|
      puts "#{a[:number]}. #{a[:name]}(#{a[:code]}) is #{a[:distance]} miles away."
      #  puts "#{v}"
    end

  end

  def self.scrape_by_zipcode( url_with_zip )

    airports = []

    doc = Nokogiri::HTML( open(url_with_zip) )

    all = doc.css("div#list tr")
    puts "\n*************************"
    puts "All:#{all}"
    puts "***********  After ALL **************\n"
    # This has all the codes together
    #code = doc.css(".loaddetails")[0].text

    doc.css("div#list tr").each_with_index do |row,i|
      puts "\n** i:#{i} **\n"
      if i > 0 && row.css("td")[0].text != "" && i < 20
        puts "\nRow: #{row}:**END OF ROW**"
        number = row.css("td")[0].text

        code = row.css("td")[1].text
        code_link = doc.css(".loaddetails").text
        distance = row.css("td")[2].text
        name = row.css("td")[3].text

        puts "Number:#{number}"
        puts "Code is:#{code}"
        puts "Distance:#{distance}"
        puts "Name:#{name}"

        airports << { number: number, code: code, distance: distance, name: name }
      end # if
    end #doc.css("div#list tr").each_with_index do |row,i|

    puts airports

    #codeLink = doc.css(".loaddetails").text

    #distance = doc.css("div#list td")[2].text


    # Site will display "Sorry, we could not find any suitable airports for this address!"
    #      if the zip code is not "valid"

    airports
  end # scrape_by_zipcode


end #class RunwayFinder::Airport
