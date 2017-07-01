class RunwayFinder::Airport

  attr_accessor :name, :code, :distance, :url, :runway

  def self.nearby
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



end
