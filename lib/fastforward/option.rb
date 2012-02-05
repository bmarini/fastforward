module FastForward
  class Option
    def initialize(name, value)
      @name, @value = name, value
    end

    def name
      "-#{@name}"
    end

    def value
      @value
    end

    def to_s
      "%s %s" % [ name, value]
    end
  end
end