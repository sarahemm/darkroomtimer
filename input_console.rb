require 'io/console'

# Based on: https://gist.github.com/acook/4190379
# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def get_key
  c = read_char

  case c
    when "\r", "\n"
      :enter
    when "\e[A"
      :up
    when "\e[B"
      :down
    when "\e[C"
      :right
    when "\e[D"
      :left
    when "\u0003"
      :exit
  end
end

class TimerModule
  class InputModule
    class Console
      def initialize
      end
    
      def is_select_pressed?
        return true if STDIN.read_nonblock(1) rescue nil
      end
    
      def wait_for_button
        case get_key
          when :left, :up
            :previous
          when :right, :down
            :next
          when :enter
            :select
          when :exit
            Kernel.exit 0
        end
      end
    end
  end
end

TimerModule::Manager.instance.register(:input, :console, TimerModule::InputModule::Console.new)
