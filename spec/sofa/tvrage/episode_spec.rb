require 'spec_helper'

module Sofa::TVRage

describe Episode do
  before do
    @info = Crack::XML.parse(File.read("spec/fixtures/tvrage/single_episode.xml"))["episode"]
  end

  subject { Episode.new(@info) }
 
  { :num        => "1",
    :num_in_season => "01",
    :prod_num   => "4V01",
    :air_date   => "1997-03-10",
    :link       => "http://www.tvrage.com/Buffy_The_Vampire_Slayer/episodes/28077",
    :title      => "Welcome to the Hellmouth (1)"
  }.each do |attr, value|
    it "should get ##{attr}" do
      subject.send(attr).should == value
    end
  end

  it "should have season number" do
    subject.should respond_to(:season_num)
  end

  it "should be #eql to episode with same attributes" do
    other = Episode.new(@info)
    subject.should == other
  end

  it "should not be #eql to episode with different attributes" do
    other = Episode.new(@info.merge("epnum" => "4"))
    subject.num.should_not == other.num
    subject.should_not == other
  end

  it "should not be #equal to episode with same attributes" do
    other = Episode.new(@info)
    subject.should_not equal(other)
  end
end

end
