# scraper class
require 'pry'
require 'nokogiri'
require 'open-uri'

class WhiskyPicker::WhiskyScraper

  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description

  def self.scrape_index (index_url )#= "https://www.thewhiskyexchange.com/c/40/single-malt-scotch-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter")
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

  def self.scrape_profile (profile_url )#= "https://www.thewhiskyexchange.com/p/4132/oban-14-year-old")
    profile = Nokogiri::HTML(open(profile_url))

    whisky = profile.css(".container")
    this_whisky = self.new
  #binding.pry
    if whisky.css(".name-container h1").children.children.text.strip == ""
      this_whisky.name = whisky.css(".name-container h1").children.first.text.strip
    else
      this_whisky.name = whisky.css(".name-container h1").children.first.text.strip + " (" + whisky.css(".name-container h1").children.children.text.strip + ")"
    end
    this_whisky.country = whisky.css("dl.meta").at('dt:contains("Country")').next_element.text.strip
    this_whisky.region_type = whisky.css(".name-container .properties li").first.text.strip
    this_whisky.proof = whisky.css(".name-container .strength").text.split(" / ").last.strip
    this_whisky.rating = whisky.css(".rating-container span").text.strip
    this_whisky.description = whisky.css("#prodDesc").text.strip

    this_whisky
  end
end
