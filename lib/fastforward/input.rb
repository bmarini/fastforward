module FastForward
  class Input
    include Options
    include InputOutputOptions

    attr_reader :filename, :options

    def initialize(filename)
      @filename = filename
      @options  = []
      yield(self) if block_given?
    end
  end
end
