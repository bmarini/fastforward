module FastForward
  class Builder
    attr_reader :global_options, :inputs, :outputs

    def initialize
      @global_options = []
      @inputs         = []
      @outputs        = []

      yield(self) if block_given?
    end

    def input(filename, &block)
      @inputs.push Input.new(filename, &block)
    end

    def output(filename, &block)
      @outputs.push Output.new(filename, &block)
    end

    def to_s
      command.to_s
    end

    private

    def command
      Command.new(self)
    end
  end
end