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
        when :green
          Adafruit::LCD::Char16x2::GREEN
        when :blue
          Adafruit::LCD::Char16x2::BLUE
        when :yellow
          Adafruit::LCD::Char16x2::YELLOW
        when :teal
          Adafruit::LCD::Char16x2::TEAL
        when :purple
          Adafruit::LCD::Char16x2::VIOLET
        when :white
          Adafruit::LCD::Char16x2::WHITE
        else
          Adafruit::LCD::Char16x2::OFF
      end
      @lcd.backlight colour_code
    end
  end
end
