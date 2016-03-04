# Load process information from files

class ProcessLoader
  def ProcessLoader.load_process(screen, input)
    processes = []
    Dir.glob("processes/*.csv").each do |filename|
      processes.push File.basename(filename).split(/\./).first
    end
    process_menu = LCDMenu.new(screen, input, "Process", processes)
    process_name = process_menu.get_selection
    process = TimerProcess.new("processes/#{process_name}.csv", process_name)
  end
end
