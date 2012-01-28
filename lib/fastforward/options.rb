module FastForward
  class Options
    class Definition
      attr_reader :name, :translation

      def initialize(name, translation, allowed_file_types, allowed_stream_types, per_stream)
        @name                 = name
        @translation          = translation
        @allowed_file_types   = allowed_file_types
        @allowed_stream_types = allowed_stream_types
        @per_stream_allowed   = per_stream
      end

      def allowed?(file_type, stream_type=nil, per_stream=false)
        file_type_allowed?(file_type)     &&
        stream_type_allowed?(stream_type) &&
        per_stream_allowed?(per_stream)
      end

      def file_type_allowed?(file_type)
        @allowed_file_types.include?(file_type) or
        raise OptionNotAllowedError, "#{name} option not supported for #{file_type} files"
      end

      def stream_type_allowed?(stream_type)
        stream_type.nil? || @allowed_stream_types.include?(stream_type) or
        raise OptionNotAllowedError, "#{name} option not supported for #{stream_type} streams"
      end

      def per_stream_allowed?(per_stream)
        !per_stream || ( per_stream && @per_stream_allowed ) or
        raise OptionNotAllowedError, "#{name} option not supported per stream"
      end
    end

    class << self
      def option(name, translation, allowed_file_types = [], allowed_stream_types = [], per_stream = false)
        definition = Definition.new(name, translation, allowed_file_types, allowed_stream_types, per_stream)
        @definitions ||= []
        @definitions.push(definition)
      end

      def video_option(name, translation, allowed_file_types, per_stream = false)
        option(name, translation, allowed_file_types, [:video], per_stream)
      end

      def audio_option(name, translation, allowed_file_types, per_stream = false)
        option(name, translation, allowed_file_types, [:audio], per_stream)
      end

      def find(name)
        name = name.to_s
        @definitions.find { |d| d.name == name }
      end
    end

    # -----------------------------------------------------------------------
    # Main Options
    # -----------------------------------------------------------------------

    # Force input or output file format. The format is normally auto detected
    # for input files and guessed from file extension for output files, so this
    # option is not needed in most cases.
    option "format", "f", [:input, :output]

    # Select an encoder (when used before an output file) or a decoder (when
    # used before an input file) for one or more streams. codec is the name of a
    # decoder/encoder or a special value copy (output only) to indicate that the
    # stream is not to be re-encoded.
    option "codec", "c", [:input, :output], [:audio, :video], true
    option "encoder", "c", [:output], [:audio, :video], true
    option "decoder", "c", [:input], [:audio, :video], true

    # Stop writing the output after its duration reaches duration. duration
    # may be a number in seconds, or in hh:mm:ss[.xxx] form.
    option "duration", "t", [:output]

    # Set the file size limit.
    option "file_size_limit", "fs", [:output]

    # When used as an input option (before -i), seeks in this input file to
    # position. When used as an output option (before an output filename),
    # decodes but discards input until the timestamps reach position. This is
    # slower, but more accurate. position may be either in seconds or in
    # hh:mm:ss[.xxx] form.
    option "position", "ss", [:input, :output]

    video_option "frame_rate", "r", [:input, :output], true
    video_option "bitrate", "b", [:output]
  end
end