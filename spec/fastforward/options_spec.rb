require 'spec_helper'

describe FastForward::Options do
  subject { FastForward::Options }

  it "can find an option" do
    subject.find("bitrate").should be_instance_of(FastForward::Options::Definition)
  end
end