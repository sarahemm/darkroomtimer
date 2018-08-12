# Load process information from a 2D barcode

require 'serialport'

class ProcessLoader
  def ProcessLoader.load_process(screen, input)
    gpio = TimerExt::Manager.instance[:raspi].gpio
    process_obj = nil
    port = SerialPort.new("/dev/ttyAMA0", 9600, 8, 1, SerialPort::NONE)
    port.read_timeout = 100
    port.read_nonblock rescue nil # empty any garbage from the buffer
    screen.clear
    screen.write "Scan Barcode Now"

    gpio[:trigger].off # active low
    process_data = ""
    start_time = Time.now
    loop do
      read_data = port.read
      break if read_data == "" and process_data != ""
      process_data += read_data
      if(gpio[:power].read != 0) then
        gpio[:trigger].on
        raise PowerException
      end
      if(Time.now - start_time > 10) then
        gpio[:trigger].on
        screen.clear
        screen.write "Barcode Timeout\nSELECT to retry "
        while input.wait_for_button != :select do
        end
        gpio[:trigger].off
        screen.clear
        screen.write "Scan Barcode Now"
        start_time = Time.now
      end
    end
    gpio[:trigger].on
    process_csv = CSV.parse(process_data)
    process_obj = TimerProcess.new(process_csv)
    screen.clear
    screen.background_colour process_obj.colour
    screen.write "#{process_obj.name} #{process_obj.modifier}\nPress to Start"
    loop do
      return process_obj if input.wait_for_button == :select
    end
  end
end
