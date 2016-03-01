class TimerUI
  class Screen
    def initialize
    end
    
    def home
      puts "---"
    end
    
    def clear
      puts "# Clear Screen"
    end
    
    def write(text)
      puts text
    end
    
    def background_colour(colour)
      puts "# Background color: #{colour}"
    end
  end
end