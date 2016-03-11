# Load process information from files

class ProcessLoader
  def ProcessLoader.load_process(screen, input)
    processes = []
    Dir.glob("processes/*.csv").each do |filename|
      processes.push File.basename(filename).split(/\./).first
    end
    process_menu = LCDMenu.new(screen, input, "Process", processes)
    process_filename = process_menu.get_selection
    process_csv = CSV.read("processes/#{process_filename}.csv")
    process = TimerProcess.new(process_csv)
  end
end
