class TimerModule
  class ScreenModule
    class Reader
      def initialize
        @lastlines = Array.new
      end
    
      def home
      end
    
      def clear
      end
    
      def write(text, flags = [])
        flags = [flags] if flags.class != Array
        # we read out each line independently to maximize the number
        # of cache hits when using paid/credit-based TTS.
        # we also skip reading any line that hasn't changes since the last
        # write, which makes the menus more fluid to use
        lines = text.split("\n")
        (0..1).each do |line|
          if(flags.include?("line#{line+1}important".to_sym) or flags.include?(:important)) then
            if(@lastlines[line] != lines[line]) then
              wait = (line == 0 and lines.length == 2 and (flags.include?(:line2important) or flags.include?(:important)))
              TimerModule::Manager.instance[:speech].say lines[line], wait
            end
            @lastlines[line] = lines[line]
          end
        end
      end
    
      def background_colour(colour)
      end
    end
  end
end

TimerModule::Manager.instance.register(:screen, :reader, TimerModule::ScreenModule::Reader.new)
