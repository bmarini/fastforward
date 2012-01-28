module FastForward
  class StreamOption < Option
    def initialize(name, value, stream_type, stream_index=nil)
      @name         = name
      @value        = value
      @stream_type  = stream_type
      @stream_index = stream_index
    end

    def name
      "-%s%s" % [ @name, stream_specifier ]
    end

    def stream_specifier
      stream_type = case @stream_type
      when :audio then ":a"
      when :video then ":v"
      else
        ""
      end

      stream_type + ( @stream_index ? ":#{@stream_index}" : "" )
    end
  end
end