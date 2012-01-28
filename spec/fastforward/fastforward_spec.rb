require 'spec_helper'

describe FastForward do
  it "has a convience method to initialize a builder object" do
    builder = FastForward.build
    builder.should be_kind_of(FastForward::Builder)
  end
end