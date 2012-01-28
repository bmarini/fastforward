module FastForward
  class Builder
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

    def command
      cmd = Sh::Cmd.new("ffmpeg") do |c|
        @inputs.each do |input|
          input.options.each do |option|
            c.opt(option.name).arg(option.value)
          end
          c.opt("-i").arg(input.filename)
        end

        @outputs.each do |output|
          output.options.each do |option|
            c.opt(option.name).arg(option.value)
          end
          c.arg(output.filename)
        end
      end
    end

    def to_s
      command.to_s
    end
  end
end