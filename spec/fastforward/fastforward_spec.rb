require 'spec_helper'

describe FastForward do
  it "has a convience method to initialize a builder object" do
    builder = FastForward.build
    builder.should be_kind_of(FastForward::Builder)
  end

  it "can set the video bitrate of the output file to 64kbit/s" do
    builder = FastForward.build do |ff|
      ff.input "input.avi"
      ff.output "output.avi" do |o|
        o.bitrate("64k").stream("video")
      end
    end

    builder.to_s.should == "ffmpeg -i input.avi -b:v 64k output.avi"
  end

  it "can force the frame rate of the output file to 24 fps" do
    builder = FastForward.build do |ff|
      ff.input "input.avi"
      ff.output "output.avi" do |o|
        o.frame_rate(24)
      end
    end

    builder.to_s.should == "ffmpeg -i input.avi -r 24 output.avi"
  end

  it "can force the frame rate of the input file (valid for raw formats only)\
 to 1 fps and the frame rate of the output file to 24 fps" do
    builder = FastForward.build do |ff|
      ff.input "input.m2v" do |i|
        i.frame_rate(1)
      end
      ff.output "output.avi" do |o|
        o.frame_rate(24)
      end
    end

    builder.to_s.should == "ffmpeg -r 1 -i input.m2v -r 24 output.avi"
  end
end