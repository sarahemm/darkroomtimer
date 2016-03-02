class TimerProcess
  def initialize(process_file)
    process_csv = CSV.read(process_file)
    process_csv.shift
    @steps = []
    process_csv.each do |step_data|
      backlight = :off
      case step_data[4].upcase
        when "Y"
          backlight = :on
        when "H"
          backlight = :half
      end
      @steps.push TimerProcessStep.new(step_data[1], step_data[0], step_data[2].to_i, step_data[3].upcase == "Y" ? true : false, backlight)
    end
  end
  
  def [](idx)
    @steps[idx]
  end
  
  def each_step
    @steps.each do |step|
      yield step
    end
  end
  
  def steps
    @steps
  end
end

class TimerProcessStep
  attr_reader :short_name, :long_name, :tweakable, :backlight
  attr_accessor :seconds

  def initialize(short_name, long_name, seconds, tweakable, backlight)
    @short_name = short_name
    @long_name = long_name
    @seconds = seconds
    @tweakable = tweakable
    @backlight = backlight
  end
end