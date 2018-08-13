# ext_wifi - Accept special barcodes to add/remove wifi networks from the
#            wpa_supplicant configuration.

class TimerExt
  class WiFi
    def initialize
    end

    def process_data(data)
      # this gets called when the user scans a barcode
      # (or potentially inputs a WiFi definition some other way)
      operation = data[0][1]
      ssid = data[0][2]
      passphrase = data[0][3]
      config_file = Digest::MD5.hexdigest ssid + ".conf"
      if(operation == "ADD") then
        puts "Adding or updating #{ssid} in #{config_file}."
        open("/etc/wpa_supplicant/config.d/#{config_file}", 'w') do |f|
          f.puts "network={\n  ssid=\"#{ssid}\"\n  psk=\"#{passphrase}\"\n}"
        end
        wifi_reconfigure
      elsif(operation == "DEL") then
        puts "Deleting #{ssid} in #{config_file}."
        File.unlink "/etc/wpa_supplicant/config.d/#{config_file}"
        wifi_reconfigure
      end
    end

    private

    def wifi_reconfigure()
      system "cat /etc/wpa_supplicant/config.d/* > /etc/wpa_supplicant/wpa_supplicant.conf"
      system "wpa_cli reconfigure"
    end
  end
end

TimerExt::Manager.instance.register(:wifi, TimerExt::WiFi.new)
