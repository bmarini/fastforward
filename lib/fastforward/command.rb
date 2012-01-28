module FastForward
  class Command
    def initialize(builder)
      @builder = builder
      @command = Sh::Cmd.new("ffmpeg")

      build_command
    end

    def build_command
      @builder.inputs.each { |input| add_input(input) }
      @builder.outputs.each { |output| add_output(output) }
    end

    def add_input(input)
      input.options.each { |option| add_option(option) }
      input.streams.each { |stream| add_stream_options(stream) }
      @command.opt("-i").arg(input.filename)
    end

    def add_output(output)
      output.options.each { |option| add_option(option) }
      output.streams.each { |stream| add_stream_options(stream) }
      @command.arg(output.filename)
    end

    def add_stream_options(stream)
      stream.options.each { |option| add_option(option) }
    end

    def add_option(option)
      @command.opt(option.name).arg(option.value)
    end

    def to_s
      @command.to_s
    end
  end
end