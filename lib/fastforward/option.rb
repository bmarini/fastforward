module FastForward
  class Option
    def initialize(name, value, opts={})
      @name, @value, @opts = name, value, defaults.merge(opts)
      @stream_type  = nil
      @stream_index = nil
    end

    def stream(type, index=nil)
      @stream_type  = type
      @stream_index = index
      self # For chaining
    end

    def defaults
      { :stream_specifier_allowed => true }
    end

    def name
      "-%s%s" % [ @name, stream_specifier ]
    end

    def value
      @value
    end

    def stream_specifier
      stream_type = case @stream_type
      when "audio" then ":a"
      when "video" then ":v"
      else
        ""
      end

      stream_type + ( @stream_index ? ":#{@stream_index}" : "" )
    end

    def to_s
      "%s %s" % [ name, value]
    end
  end
end