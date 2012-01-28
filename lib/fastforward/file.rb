module FastForward
  class File
    include HasOptions

    attr_reader :filename, :options, :streams

    def initialize(filename, type)
      @filename  = filename
      @file_type = type
      @options   = []
      @streams   = []

      yield(self) if block_given?
    end

    def stream(type, index=nil)
      Stream.new(@file_type, type, index).tap do |stream|
        @streams.push(stream)
      end
    end

    def method_missing(method, *args, &block)
      option = Options.find(method)
      if option && option_allowed?(option)
        add_option(option.translation, *args)
        self
      else
        super
      end
    end

    def option_allowed?(option)
      option.allowed?(@file_type)
    end

  end
end