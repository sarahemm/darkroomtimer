require 'lcd/char16x2'
include Adafruit::LCD::Char16x2

class TimerUI
  class Screen
    def initialize
      @lcd = Adafruit::LCD::Char16x2.new
      @lcd.backlight(Adafruit::LCD::Char16x2::RED)
      @lcd.clear
    end
    
    def home
      @lcd.home
    end
    
    def clear
      @lcd.clear
    end
    
    def write(text)
      @lcd.message text
    end
    
    def background_colour(colour)
      colour_code = case(colour)
        when :black
          OFF
        when :red
          RED
        when :white
          WHITE
        when else
          OFF
      end
    end
end