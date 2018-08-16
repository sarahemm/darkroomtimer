class TimerModule
  class InputModule
    class GPIOButtons
      def initialize()
        @gpio = TimerModule::Manager.instance[:raspi].gpio
      end
    
      def is_select_pressed?
          @gpio[:select].read == 0
      end
  
      def wait_for_button
        while(true) do
          if(@gpio[:select].read != 1) then
            while(@gpio[:select].read != 1) do
              sleep 0.2
            end
            return :select
          end
          if(@gpio[:next].read != 1) then
            while(@gpio[:next].read != 1) do
              sleep 0.2
            end
            return :next
          end
          if(@gpio[:previous].read != 1) then
            while(@gpio[:previous].read != 1) do
              sleep 0.2
            end
            return :previous
          end
          raise PowerException if @gpio[:power].read != 0
          sleep 0.1
        end
      end
    end
  end
end

TimerModule::Manager.instance.register(:input, :gpiobuttons, TimerModule::InputModule::GPIOButtons.new)
