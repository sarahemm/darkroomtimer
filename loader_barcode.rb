# Load process information from a 2D barcode

require 'serialport'
require 'pi_piper'

class ProcessLoader
  def ProcessLoader.load_process(screen, input)
    # barcode reader trigger line
    trigger_gpio = PiPiper::Pin.new :pin => 25, :direction => :out
    power_gpio = PiPiper::Pin.new   :pin => 21, :pull => :up

    process_obj = nil
    port = SerialPort.new("/dev/ttyAMA0", 9600, 8, 1, SerialPort::NONE)
    port.read_timeout = 100
    screen.clear
    screen.write "Scan Barcode Now"

    loop do
      trigger_gpio.off # active low
      process_data = ""
      loop do
        read_data = port.read
        break if read_data == "" and process_data != ""
        process_data += read_data
        if(input.is_select_pressed? and process_obj) then
          trigger_gpio.on
          return process_obj
        end
        if(power_gpio.read != 0) then
          trigger_gpio.on
          raise PowerException
        end
      end
      puts "doneish"
      trigger_gpio.on
      process_csv = CSV.parse(process_data)
      screen.clear
      screen.write "#{process_csv[0][0]}\nPress to Start"
      process_obj = TimerProcess.new(process_csv)
    end
  end
end
