module FastForward
  class Output
    include Options
    include InputOutputOptions

    attr_reader :filename, :options

    def initialize(filename)
      @filename = filename
      @options  = []
      yield(self) if block_given?
    end

    def bitrate(value)
      add_option("b", value)
    end
  end
end
