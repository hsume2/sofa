require 'spec_helper'

module Sofa::TVRage

describe Season do
  describe "with 1 episode" do
    before do
      @info = Crack::XML.parse(File.read("spec/fixtures/tvrage/episode_list_one_season.xml"))["Show"]["Episodelist"]["Season"]
      @episodes = [Episode.new(@info["episode"])]
    end

    subject { Season.new(@info) }

    it "should have #no" do
      subject.no.should == "0"
    end

    it "should have episode" do
      subject.episodes.should == @episodes
      subject.episodes.size.should == 1
    end

    it "should be #eql to season with same attributes" do
      other = Season.new(@info)
      subject.should == other
    end

    it "should not be #eql to season with different attributes" do
      other = Season.new(@info.merge("no" => "23"))
      subject.should_not == other
    end

    it "should not be #equal to season with same attributes" do
      other = Season.new(@info)
      subject.should_not equal(other)
    end
  end
  
  describe "with 2 episodes" do
    before do
      @info = Crack::XML.parse(File.read("spec/fixtures/tvrage/episode_list_two_episodes.xml"))["Show"]["Episodelist"]["Season"]
      @episodes = []
      @info["episode"].each do |episode|
        @episodes << Episode.new(episode)
      end
    end

    subject { Season.new(@info) }

    it "should have #no" do
      subject.no.should == "1"
    end

    it "should have episodes" do
      subject.episodes.should == @episodes
      subject.episodes.size.should == 2
    end
  end
end

end
