require 'singleton'

class TimerModule
  class Manager
    include Singleton
    
    # load all of one type of module
    def self.load_type(category)
      module_cfg = ConfigManager['Modules']
      return nil if !module_cfg[category.to_s]
      module_cfg[category.to_s].split(",").each do |a_module|
        require "./#{category.to_s}_#{a_module}.rb"
      end
    end
    
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

    def method_missing(method, *args, &block)
      retval = nil
      @members.each do |key, member|
        this_retval = member.send(method, *args, &block)
        retval = this_retval if this_retval
      end
      retval
    end
  end
end
