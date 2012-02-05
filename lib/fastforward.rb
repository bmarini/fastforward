require "sh"
require "fastforward/version"
require "fastforward/builder"
require "fastforward/command"
require "fastforward/option"
require "fastforward/stream_option"
require "fastforward/has_options"
require "fastforward/file"
require "fastforward/stream"

module FastForward
  def self.build(&block)
    Builder.new(&block)
  end

  class FastForwardError < StandardError; end
  class OptionNotAllowedError < FastForwardError; end
end
