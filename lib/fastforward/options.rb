module FastForward
  module Options
    def add_option(name, value)
      Option.new(name, value).tap do |opt|
        @options.push(opt)
      end
    end
  end
end