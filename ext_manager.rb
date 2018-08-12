require 'singleton'

class TimerExt
  class Manager
    include Singleton
    
    # register a class as an external module
    def register(name, instance)
      @ext_modules = Hash.new if !@ext_modules
      STDERR.puts "Registering extension module #{name}."
      @ext_modules[name] = instance
    end
    
    def [](name)
      return if !@ext_modules
      @ext_modules[name]
    end
  end
end
