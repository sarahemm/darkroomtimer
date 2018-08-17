require './cerevoice.rb'

class TimerModule
  class SpeechModule
    class Cerevoice
      def initialize()
        username = ConfigManager['CereVoice']['UserID']
        password = ConfigManager['CereVoice']['Password']
        @cerevoice = CereVoice.new(username, password, "speech_cache")
      end
    
      def munge(text)
        text.gsub!("B&W", "Black and White")
        text.gsub!("RA-4", "R Eh 4")
        text
      end
    
      def say(text, wait = false)
        text = munge(text)
        speech_file = @cerevoice.render_speech(text)
        wait_flag = wait ? "" : "&"
        system "killall mpg321 2>/dev/null; mpg321 -q #{speech_file} 2>&1 | grep -v tcgetattr #{wait_flag}"
      end
    
      def prepare(text)
        # render the speech to a file in the cache, but don't actually play it
        text = munge(text)
        @cerevoice.render_speech text
      end
    end
  end
end

TimerModule::Manager.instance.register(:speech, :cerevoice, TimerModule::SpeechModule::Cerevoice.new)
