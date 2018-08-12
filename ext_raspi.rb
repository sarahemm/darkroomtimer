require 'pi_piper'

class TimerExt
  class RasPi
    attr_reader :gpio

    def initialize
      @gpio = Hash.new
      @gpio[:select]   = PiPiper::Pin.new :pin => 26, :pull => :up
      @gpio[:next]     = PiPiper::Pin.new :pin => 20, :pull => :up
      @gpio[:previous] = PiPiper::Pin.new :pin => 16, :pull => :up
      @gpio[:power]    = PiPiper::Pin.new :pin => 21, :pull => :up
      @gpio[:trigger]  = PiPiper::Pin.new :pin => 25, :direction => :out
    end
  end
end

TimerExt::Manager.instance.register(:raspi, TimerExt::RasPi.new)
