require 'lcd/char16x2'

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
          Adafruit::LCD::Char16x2::OFF
        when :red
          Adafruit::LCD::Char16x2::RED
        when :white
          Adafruit::LCD::Char16x2::WHITE
        else
          Adafruit::LCD::Char16x2::OFF
      end
    end
  end
end
