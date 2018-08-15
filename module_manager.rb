require 'singleton'

class TimerModule
  class Manager
    include Singleton
    
    # register a class as an external module
    def register(category, name, instance)
      @modules = Hash.new if !@modules
      @modules[category] = Collection.new if !@modules.key? category
      @modules[category][name] = instance
    end
    
    def [](category)
      return if !@modules
      @modules[category]
    end
  end

  class Collection
    def initialize
      @members = Hash.new
      puts "Initializing new module collection."
    end

    def +(instance)
      @members[@members.length] = instance
    end

    def []=(name, instance)
      @members[name] = instance
      puts "Collection item #{name} set to #{instance}."
    end
  end
end
