require 'spec_helper'

describe FastForward::Builder do
  subject { FastForward::Builder.new }
  it "builds a command string for ffmpeg" do
    subject.to_s.should == "ffmpeg"
  end

  it "can set the video bitrate of the output file to 64kbit/s" do
    builder = subject.tap do |ff|
      ff.input "input.avi"
      ff.output "output.avi" do |o|
        o.stream("video").b("64k")
      end
    end

    builder.to_s.should == "ffmpeg -i input.avi -b:v 64k output.avi"
  end

  it "can force the frame rate of the output file to 24 fps" do
    builder = subject.tap do |ff|
      ff.input "input.avi"
      ff.output "output.avi" do |o|
        o.r(24)
      end
    end

    builder.to_s.should == "ffmpeg -i input.avi -r 24 output.avi"
  end

  it "can force the frame rate of the input file (valid for raw formats only)\
 to 1 fps and the frame rate of the output file to 24 fps" do
    builder = subject.tap do |ff|
      ff.input "input.m2v" do |i|
        i.r(1)
      end
      ff.output "output.avi" do |o|
        o.r(24)
      end
    end

    builder.to_s.should == "ffmpeg -r 1 -i input.m2v -r 24 output.avi"
  end

  it "can specify codecs and multiple options per stream" do
    builder = subject.tap do |ff|
      ff.input "INPUT"
      ff.output "OUTPUT" do |o|
        o.stream("v").c("libx264").r(24)
        o.stream("a").c("copy")
      end
    end

    builder.to_s.should == "ffmpeg -i INPUT -c:v libx264 -r:v 24 -c:a copy OUTPUT"
  end
end
