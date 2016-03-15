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
    port.read_nonblock rescue nil # empty any garbage from the buffer
    screen.clear
    screen.write "Scan Barcode Now"

    trigger_gpio.off # active low
    process_data = ""
    loop do
      read_data = port.read
      break if read_data == "" and process_data != ""
      process_data += read_data
      if(power_gpio.read != 0) then
        trigger_gpio.on
        raise PowerException
      end
    end
    trigger_gpio.on
    p process_data
    process_csv = CSV.parse(process_data)
    screen.clear
    screen.write "#{process_csv[0][0]}\nPress to Start"
    process_obj = TimerProcess.new(process_csv)
    loop do
      return process_obj if input.wait_for_button == :select
    end
  end
end
