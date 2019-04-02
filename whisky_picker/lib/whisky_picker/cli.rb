#CLI Controller
require_relative "whisky_scraper.rb"

class WhiskyPicker::CLI

BASEPATH = "http://www.thewhiskyexchange.com/"

  def call
    greet
    pick
    menu
    laters
  end

  def greet
    puts "Welcome to Whisky Picker...ready to find some whisky?"
    puts ""
  end

  def pick
    #method to ask user to pick whiskies and then select the specific whisky from a list and in order to display it in a menu (to follow)
    #display countries
    country
  end

  def country
    #display list of countries
    puts <<-DOC
    Which country would you like to explore?

    1. Scotland
    2. Ireland
    3. United States of America
    4. Japan
    5. Canada
    6. Other countries

    DOC

    input = nil
    while input != 'exit'
      puts "Please enter number of desired destination"
      input = gets.strip
      case input
      when "1"
        scotch #call specific methods to display list of selected whisky origin
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

  def scotch
    puts <<-DOC
    Which type of Scotch whisky would you like to explore?

    1. Single Malt
    2. Blended Malt
    3. Blended
    4. Grain
    DOC

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
  def single_malt
    puts "Let's explore single malt Scotch whiskies!"
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

  def whisky_list(url)
    #send url for selected country to whisky scraper class (in order to create list of whiskies from selected country)
    @whiskies = WhiskyPicker::WhiskyScraper.scrape_index(BASEPATH + url) #array
    #use returned array to create list of whiskies
    @whiskies.each_with_index do |whisky, index|
      puts "#{index+1}. #{whisky.name}" #index (#). whisky name
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

        another_one?
      end
    end
  end

  def another_one?
    puts "Want to pick another one? Type back to return to most recent list, start to restart or exit to leave."

    input = gets.strip
    if input == "start" || input == "restart" || input == "top"
      pick
    elsif input == "exit" || input == "bye"
      laters
    elsif input == "back" || input == "list" || input == "yes" || input == "y"
      @whiskies.each_with_index do |whisky, index|
        puts "#{index+1}. #{whisky.name}"
      end
    else
      another_one?
    end
  end

  #exit CLI
  def laters
    puts "Thanks for stopping by. Laters!"
    exit
  end
end
