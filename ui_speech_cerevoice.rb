require './cerevoice.rb'

class TimerUI
  class Speech
    def initialize(username, password)
      @cerevoice = CereVoice.new(username, password, "speech_cache")
    end
    
    def munge(text)
      text.gsub!("B&W", "Black and White")
      text
    end
    
    def say(text)
      text = munge(text)
      speech_file = @cerevoice.render_speech(text)
      system "killall -q mpg321; mpg321 #{speech_file} &"
    end
    
    def prepare(text)
      # render the speech to a file in the cache, but don't actually play it
      text = munge(text)
      @cerevoice.render_speech text
    end
    
    def say_wait(text)
      text = munge(text)
      speech_file = @cerevoice.render_speech(text)
      system "killall -q mpg321; mpg321 #{speech_file}"
    end
  end
end
