# scraper class
require 'pry'

class WhiskyPicker::WhiskyScraper
  attr_accessor :name, :country, :region_type, :proof, :rating, :description

  def self.scrape_index (index_url)
    whiskies = []
    index = Nokogiri::HTML(open(index_url))

    get_whiskies = index.css(".item")
    get_whiskies.each do |whisky|
      my_whisky = whisky.new
      binding.pry
      my_whisky.name = whisky.css("a").attr("href")

end
