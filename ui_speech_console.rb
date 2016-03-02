class TimerUI
  class Speech
    def initialize(username = "", password = "")
      # we don't care about u/p but other speech engines might
    end
  
    def say(text)
      puts "SPEECH: #{text}"
    end
    
    def prepare(text)
      puts "PREPARE SPEECH: #{text}"
    end
    
    def say_wait(text)
      puts "SPEECH: #{text}"
    end
  end
end