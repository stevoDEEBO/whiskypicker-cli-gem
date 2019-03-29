# scraper class
require 'pry'
require 'nokogiri'
require 'open-uri'

class WhiskyPicker::WhiskyScraper

  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description

  def self.scrape_index (index_url = "https://www.thewhiskyexchange.com/c/40/single-malt-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter")
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



end
