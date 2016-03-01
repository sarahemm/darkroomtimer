require 'pi_piper'

class TimerUI
  class Input
    def initialize
    end
    
    def is_select_pressed?
        select_gpio = PiPiper::Pin.new   :pin => 26, :pull => :up
        select_gpio.read == 0
    end
  
    def wait_for_input
        power_gpio = PiPiper::Pin.new    :pin => 21, :pull => :up
        select_gpio = PiPiper::Pin.new   :pin => 26, :pull => :up
        next_gpio = PiPiper::Pin.new     :pin => 20, :pull => :up
        previous_gpio = PiPiper::Pin.new :pin => 16, :pull => :up
      
        while(true) do
          if(select_gpio.read != 1) then
            while(select_gpio.read != 1) do
              sleep 0.2
            end
            return :select
          end
          if(next_gpio.read != 1) then
            while(next_gpio.read != 1) do
              sleep 0.2
            end
            return :next
          end
          if(previous_gpio.read != 1) then
            while(previous_gpio.read != 1) do
              sleep 0.2
            end
            return :previous
          end
          raise PowerException if power_gpio.read != 0
          sleep 0.1
        end
    end
  end
end
