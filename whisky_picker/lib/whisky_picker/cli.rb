require_relative "whisky_scraper.rb"

#CLI Controller
class WhiskyPicker::CLI

#include base path to append urls of whisky pages
BASEPATH = "http://www.thewhiskyexchange.com/"

  #welcome user to gem, pick a whisky and exit!
  def call
    greet
    pick
    menu
    laters
  end

  #greet user
  def greet
    puts "Welcome to Whisky Picker...ready to find some whisky?"
    puts ""
  end

  #list search options
  def pick
    country
  end

  #list countries and prompt user for country selection
  def country
    puts <<-DOC
    Which country would you like to explore?

    1. Scotland
    2. Ireland
    3. United States of America
    4. Japan
    5. Canada
    6. Other countries

    DOC

    #get user input
    input = nil
    while input != 'exit'
      puts "Please enter number of desired destination"
      input = gets.strip
      case input
      when "1"
        scotch #country methods to search corresponding webpages
        break
      when "2"
        irish
        break
      when "3"
        american
        break
      when "4"
        japanese
        break
      when "5"
        canadian
        break
      when "6"
        other
        break
      when "back"
        country
        break
      when "exit"
        laters
      else puts "Didn't quite catch that. Please enter number of desired country or type back for country list or exit to leave."
      end
    end
  end

  #scotch sections of thewhiskyexchange.com has an additional drill down by type of Scotch in order to find list of Scotch whiskies
  #list search options by type of Scotch whiskies here and prompt user for type of Scotch selection
  def scotch
    puts <<-DOC
    Which type of Scotch whisky would you like to explore?

    1. Single Malt
    2. Blended Malt
    3. Blended
    4. Grain
    DOC

    #prompt user for desired type of scotch whisky selection
    input = nil
    while input != "exit"
      puts "Please enter number of desired type of Scotch whisky"
      input = gets.strip
      case input
      when "1"
        single_malt
        break
      when "2"
        blended_malt
        break
      when "3"
        blended
        break
      when "4"
        grain
        break
      when "back"
        scotch
        break
      when "start"
        country
        break
      when "exit"
        laters
      else
        puts "Didn't quite catch that. Please enter number of desired country or type back for list of Scotch whiskies, start for country list or exit to leave."
      end
    end
  end

  #whisky origins here
  #show list of specific whiskies
  def single_malt
    puts "Let's explore single malt Scotch whiskies!"
    #call method to list whiskies for this particular type
    whisky_list('c/40/single-malt-scotch-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter')
  end

  def blended_malt
    puts "Let's explore blended malt Scotch whiskies!"
    whisky_list('c/309/blended-malt-scotch-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter')
  end

  def blended
    puts "Let's explore blended Scotch whiskies!"
    whisky_list('c/304/blended-scotch-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter')
  end

  def grain
    puts "Let's explore grain Scotch whiskies!"
    whisky_list('c/310/grain-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  def irish
    puts "Let's explore Irish whiskies!"
    whisky_list('c/32/irish-whiskey?filter=true&rfdata=~size.76~pr.100#productlist-filter')
  end

  def american
    puts "Let's explore American whiskies!"
    whisky_list('c/33/american-whiskey?filter=true#productlist-filter')
  end

  def japanese
    puts "Let's explore Japanese whiskies!"
    whisky_list('c/35/japanese-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter')
  end

  def canadian
    puts "Let's explore Canadian whiskies!"
    whisky_list('c/34/canadian-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  def other
    puts "Let's explore other whiskies of the world!"
    whisky_list('c/305/world-whisky?filter=true&rfdata=~size.76~pr.100#productlist-filter')
  end

  #display list of whiskies for selected country by using scraper create array of scraped whiskies and a hash for each individual whisky
  def whisky_list(url)
    @whiskies = WhiskyPicker::WhiskyScraper.scrape_index(BASEPATH + url) #array
    #display list of whiskies
    @whiskies.each_with_index do |whisky, index|
      puts "#{index+1}. #{whisky.name}"
    end
  end

  #display menu results with details about selected whisky
  def menu
    input = nil
    while input != 'exit'
      puts "Please enter number of desired whisky"
      input = gets.strip

      #send selected whisky's webpage url to scraper to scrape info from profile page
      if input.to_i > 0 && input.to_i+1 << @whiskies.size
        whisky = @whiskies[input.to_i-1]

        #have scraper scrape profile page for selected whisky
        my_whisky = WhiskyPicker::WhiskyScraper.scrape_profile(BASEPATH + whisky.profile_url)

        #display selected whisky profile info
        puts "Name: #{my_whisky.name}"
        puts "Country: #{my_whisky.country}"
        puts "Region and/or Type: #{my_whisky.region_type}"
        puts "Proof: #{my_whisky.proof}"
        if my_whisky.rating == ""
          puts "Customer rating: unrated"
        else
          puts "Customer rating: #{my_whisky.rating}/5 stars"
        end
        puts "Description: #{my_whisky.description}"
        puts ""
        puts ""

        #prompt user for another selection if desired
        another_one?
      end
    end
  end

  #prompt user for another selection if desired
  def another_one?
    puts "Want to pick another one? Type back to return to most recent list, start to restart or exit to leave."

    input = gets.strip
    #anticipate responses
    if input == "start" || input == "restart" || input == "top"
      pick
    elsif input == "exit" || input == "bye"
      laters
    elsif input == "back" || input == "list" || input == "yes" || input == "y"
      @whiskies.each_with_index do |whisky, index|
        puts "#{index+1}. #{whisky.name}"
      end
    else
      #if inappropriate responses, prompt again
      another_one?
    end
  end

  #exit CLI
  def laters
    puts "Thanks for stopping by. Laters!"
    exit
  end
end
