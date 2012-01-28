module FastForward
  module HasOptions
    def add_option(name, value)
      Option.new(name, value).tap do |opt|
        @options.push(opt)
      end
    end

    def add_stream_option(name, value, stream_type, stream_index=nil)
      StreamOption.new(name, value, stream_type, stream_index).tap do |opt|
        @options.push(opt)
      end
    end
  end
end