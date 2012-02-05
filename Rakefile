require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Exercise the library with a video conversion"
task :run do
  require 'fastforward'
  require 'open3'

  cmd = FastForward.build do |ff|
    ff.input "tmp/Take_0000.mov"
    ff.output "tmp/Take_000.mp4"
  end

  Open3.popen3(cmd.to_s) do |stdin, stdout, stderr, wait_thr|
    pid         = wait_thr.pid   # pid of the started process.
    puts "Started #{cmd.to_s} with pid #{pid}"

    line = ""
    total_frames  = nil
    current_frame = nil
    frame_rate    = 29.97

    stderr.each_char do |char|
      case char
      when "\n", "\r", "\b"
        if line =~ /Duration: (\d{2}):(\d{2}):(\d{2})\.\d{2}/
          total_frames = ( ($1).to_i * 60*60 + ($2).to_i * 60 + ($3).to_i ) * frame_rate
          puts "Approx total frames: #{total_frames}", "\n"
        end

        if line =~ /frame=\s+(\d+)/
          current_frame   = ($1).to_i
          percent_complete = ( current_frame / total_frames.to_f * 10000 ).to_i / 100.0
          print "#{percent_complete}% complete\r"
        elsif current_frame
          puts "100.00% complete"
          current_frame = nil
        end

        line = ""
      else
        line << char
      end
    end

    exit_status = wait_thr.value # Process::Status object returned.
  end
end