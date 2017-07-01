class RunwayFinder::Airport

  attr_accessor :name, :code, :distance, :url, :runway

  def self.nearby( zip_code )

    puts "Searching for airports near the #{zip_code} zip code."
    #https://landingfinder.com/index.php?address=60005
    #self.send("#{k}=", v)

    url_with_zip = ""
    url_with_zip = "https://landingfinder.com/index.php?address=#{zip_code}"
    puts "URL:#{url_with_zip}"
    scrape_by_zipcode( url_with_zip )

    puts "These are near by"
    airport_1 = self.new
    airport_1.name = "O'hare"
    airport_1.code = "ORD"
    airport_1.distance = "8.7"
    airport_1.url = "www.flychicago.com/ohare/home/pages/default.aspx"

    airport_2 = self.new
    airport_2.name = "Lake in the Hills"
    airport_2.code = "3CK"
    airport_2.distance = "19.87"
    airport_2.url = "www.lakeinthehills.com"

    # maybe add link to actual runway numbers/length condition, etc...
    # it would be a Runway objects
    #airport_1.runway
    [airport_1, airport_2]
  end

  def self.scrape_by_zipcode( url_with_zip )
    doc = Nokogiri::HTML( open(url_with_zip) )

    all = doc.css("div#list tr td")
    puts "\n*************************"
    puts "All:#{all}"
    puts "*************************\n"
    all.each.with_index(1) do |row, i|
      puts "\nRow #{i}"
      number = row.css("td")[0]
      puts "Number:#{number}"

      code = doc.css(".loaddetails").text
      puts "Code is:#{code}"

      distance = row.css("td")[2].text
      puts "Distance:#{distance}"

      manager = row.css("td title")[3]
      puts "Manager:#{manager}"

      name = row.css("td")[3].text
      puts "Name:#{name}"

      distance = row.css("div#list td")[2].text
    end

    code = doc.css(".loaddetails").text
    distance = doc.css("td")[2].text
    manager = doc.css("td title")[3]
    name = doc.css("td")[3].text

    distance = doc.css("div#list td")[2].text

    puts "\n*** AFTER  ***"
    puts "Number:#{number}"
    puts "Code is:#{code}"
    puts "Distance:#{distance}"
    puts "Manager:#{manager}"
    puts "Name:#{name}"
    puts "\n*** AFTER  ***"


    # Site will display "Sorry, we could not find any suitable airports for this address!"
    #      if the zip code is not "valid"


# SAMPLE
#    doc = Nokogiri::HTML(html)
#    rows = doc.xpath('//table/tbody[@id="threadbits_forum_251"]/tr')
#    details = rows.collect do |row|
#      detail = {}
#      [
#        [:title, 'td[3]/div[1]/a/text()'],
#        [:name, 'td[3]/div[2]/span/a/text()'],
#        [:date, 'td[4]/text()'],
#        [:time, 'td[4]/span/text()'],
#        [:number, 'td[5]/a/text()'],
#        [:views, 'td[6]/text()'],
#      ].each do |name, xpath|
#        detail[name] = row.at_xpath(xpath).to_s.strip
#      end
#      detail
#    end
#    pp details

    # => [{:time=>"23:35",
    # =>   :title=>"Vb4 Gold Released",
    # =>   :number=>"24",
    # =>   :date=>"06 Jan 2010",
    # =>   :views=>"1,320",
    # =>   :name=>"Paul M"}]
  end


end
