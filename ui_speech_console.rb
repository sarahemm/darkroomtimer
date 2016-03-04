class TimerUI
  class Speech
    def initialize(username = "", password = "")
      # we don't care about u/p but other speech engines might
    end

    def munge(text)
      text.gsub!("B&W", "Black and White")
      text
    end
  
    def say(text)
      text = munge(text)
      puts "SPEECH: #{text}"
    end
    
    def prepare(text)
      text = munge(text)
      puts "PREPARE SPEECH: #{text}"
    end
    
    def say_wait(text)
      text = munge(text)
      puts "SPEECH: #{text}"
    end
  end
end