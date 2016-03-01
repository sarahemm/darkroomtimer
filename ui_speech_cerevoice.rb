require './cerevoice.rb'

class TimerUI
  class Speech
    def initialize(username, password)
      @cerevoice = CereVoice.new(username, password, "speech_cache")
    end
  
    def say(text)
      speech_file = @cerevoice.render_speech(text)
      system "mpg321 #{speech_file} &"
    end
  
    def say_wait(text)
      speech_file = @cerevoice.render_speech(text)
      system "mpg321 #{speech_file}"
    end
  end
end