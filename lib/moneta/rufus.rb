begin
  require "rufus/tokyo"
rescue LoadError
  puts "You need the rufus gem to use the Rufus moneta store"
  exit
end

module Moneta
  class BasicRufus < ::Rufus::Tokyo::Cabinet 
    include Defaults
       
    def initialize(options = {})
      file = options[:file]
      super("#{file}.tch")
    end
    
    def key?(key)
      !!self[key]
    end
    
    def [](key)
      if val = super
        Marshal.load(val)
      end
    end
    
    def []=(key, value)
      super(key, Marshal.dump(value))
    end    
  end
  
  class Rufus < BasicRufus
    include Expires
    
    def initialize(options = {})
      file = options[:file]
      @expiration = BasicRufus.new(:file => "#{file}_expires")
      super
    end
    
    def close
      @expiration.close
      super
    end
  end
end