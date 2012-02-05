module FastForward
  class Stream
    include HasOptions

    attr_reader :options

    def initialize(file_type, stream_type, stream_index = nil)
      @file_type    = file_type
      @stream_type  = stream_type.to_sym
      @stream_index = stream_index
      @options      = []
    end

    def method_missing(method, *args, &block)
      add_stream_option(method, *(args + [@stream_type, @stream_index]) )
      self
    end
  end
end