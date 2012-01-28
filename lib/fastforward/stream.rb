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
      option = Options.find(method)
      if option && option_allowed?(option)
        add_stream_option(option.translation, *(args + [@stream_type, @stream_index]) )
        self
      else
        super
      end
    end

    def option_allowed?(option)
      option.allowed?(@file_type, @stream_type, @stream_index != nil)
    end
  end
end