class TimerModule
  class SpeechModule
    class Console
      def initialize()
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
end

TimerModule::Manager.instance.register(:speech, :console, TimerModule::SpeechModule::Console.new)
