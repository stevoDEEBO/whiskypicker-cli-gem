#CLI Controller

class WhiskyPicker::CLI

BASEPATH = 'http://www.thewhiskyexchange.com'

  def call

    greeting
    pick
    menu
    laters
  end

  def greeting
    puts "Welcome to Whisky Picker...ready to find some whisky?"
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

    while input != 'exit'
      puts "Please enter number of desired destination"
      input = gets.strip
      case input
      when "1"
        scotch #call specific methods to display list of selected whisky origin
      when "2"
        irish
      when "3"
        american
      when "4"
        japanese
      when "5"
        canadian
      when "6"
      else puts "Didn't quite catch that. Please enter number of desired country type exit to leave."
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
      when "2"
        blended_malt
      when "3"
        blended
      when "4"
        grain
      else
        puts "Didn't quite catch that. Please enter number of desired country exit to leave."
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
    @whiskies = WhiskyPicker::WhiskyScraper.scrape_index(BASEPATH + 'url') #array
    #use returned array to create list of whiskies
    @whiskies.each_with_index do |whisky, index|
      puts "#{index}. #{whisky.name}" #index (#). whisky name
    end
  end

  def menu
    #ask user for specific whisky selection and display that whisky's info
    input = nil
    while input != 'exit'
      puts "Please enter number of desired whisky"
      input = gets. strip

      #send selected whisky's webpage url to whisky scraper to scrape info from profile page
      whisky = @whiskies[input.to_i] #create local variable from user's selection
      WhiskyPicker::WhiskyScraper.scrape_profile(whisky.profile_url) #send url of that variable to scraper class to scrape profile page

      #display selected whisky's info
      puts "Name: #{whisky.name}"
      puts "Country: #{whisky.country}"
      puts "Region/Type: #{whisky.region_type}"
      puts "Proof: #{whisky.proof}"
      puts "Rating: #{whisky.rating}"
      puts "Description: #{whisky.description}"
    end
  end

  #exit CLI
  def laters
    puts "Thanks for stopping by. Laters!"
    exit
  end

end
