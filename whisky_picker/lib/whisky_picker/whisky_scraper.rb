# scraper class
require 'pry'
require 'nokogiri'
require 'open-uri'

class WhiskyPicker::WhiskyScraper

  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description

  def self.scrape_index (index_url = "https://www.thewhiskyexchange.com/c/40/single-malt-scotch-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter")
    whiskies = []
    index = Nokogiri::HTML(open(index_url))

    get_whiskies = index.css(".item")
    get_whiskies.each do |whisky|
      my_whisky = self.new
      my_whisky.name = whisky.css("a .name").text.strip
      my_whisky.profile_url = whisky.css("a").attr("href").text.strip
      whiskies << my_whisky
    end
    whiskies
  end

  def self.scrape_profile (index_url = "https://www.thewhiskyexchange.com/c/40/single-malt-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter")
    profile = Nokogiri::HTML(open(index_url))

    whisky = index.css(".container")
    this_whisky = self.new
    this_whisky.name = whisky.css(".name-container h1").text.strip
    this_whisky.country = whisky.css(".details dl.meta").nth-child(6).text.strip
    this_whisky.region_type = whisky.css("").text.strip
    this_whisky.proof = whisky.css("").text.strip
    this_whisky.rating = whisky.css("").text.strip
    this_whisky.description = whisky.css("").text.strip

    this_whisky
  end
end
