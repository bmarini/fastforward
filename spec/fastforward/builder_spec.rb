require 'spec_helper'

describe FastForward::Builder do
  subject { FastForward::Builder.new }
  it "builds a command string for ffmpeg" do
    subject.to_s.should == "ffmpeg"
  end
end
