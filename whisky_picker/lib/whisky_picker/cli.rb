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

  #whisky origins here
  def scotch
    puts "Let's explore Scotch whiskies!"
    #method to return url for page of Scotch whiskies
    whisky_url(  #thewhiskyexchange.com/'scotch whisky webpage')
  end

  def irish
    puts "Let's explore Irish whiskies!"
    #method to return url for page of irish whiskies
    whisky_url(  #thewhiskyexchange.com/'irish whisky webpage')
  end

  def american
    puts "Let's explore American whiskies!"
    #method to return url for page of american whiskies
    whisky_url(  #thewhiskyexchange.com/'american whisky webpage')
  end

  def japanese
    puts "Let's explore Japanese whiskies!"
    #method to return url for page of japanese whiskies
    whisky_url(  #thewhiskyexchange.com/'japanese whisky webpage')
  end

  def canadian
    puts "Let's explore Canadian whiskies!"
    #method to return url for page of canadian whiskies
    whisky_url(  #thewhiskyexchange.com/'canadian whisky webpage')
  end

  def other
    puts "Let's explore whiskies from other countries!"
    #method to return url for page of other whiskies
    whisky_url(  #thewhiskyexchange.com/'other whisky webpage')
  end

  def whisky_url(url)
    #send url for selected country to whisky scraper class (in order to create list of whiskies from selected country)
    @whiskies = WhiskyPicker::WhiskyScraper.scrape_index(url) #array
    #use returned array to create list of whiskies
    @whiskies.each_with index |whisky, index| do
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
      
  end

end
