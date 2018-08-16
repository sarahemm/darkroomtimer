require 'singleton'

class ConfigManager
  include Singleton
    
  # register a class as an external module
  def self.load()
    @cfg = IniFile.load("/etc/darkroomtimer.conf")
    @cfg = IniFile.load("./darkroomtimer.conf") unless @cfg
    @cfg
  end

  def self.[](category)
    return @cfg[category]
  end
end
