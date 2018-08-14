require 'singleton'

class TimerModule
  class Manager
    include Singleton
    
    # register a class as an external module
    def register(category, name, instance)
      @modules = Hash.new if !@modules
      @modules[category] = Hash.new if !@modules.key? category
      @modules[category][name] = instance
    end
    
    def [](category)
      return if !@modules
      @modules[category]
    end
  end
end
