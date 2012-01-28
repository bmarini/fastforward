require "sh"
require "fastforward/version"
require "fastforward/builder"
require "fastforward/command"
require "fastforward/option"
require "fastforward/options"
require "fastforward/input_output_options"
require "fastforward/input"
require "fastforward/output"

module FastForward
  # Your code goes here...
  def self.build(&block)
    Builder.new(&block)
  end
end
