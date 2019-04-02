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

  
end
