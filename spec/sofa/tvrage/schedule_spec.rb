require 'spec_helper'

module Sofa::TVRage

describe Schedule do
  before do
    @country = "US"
    @xml = File.read("spec/fixtures/tvrage/full_schedule.xml")
    FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/fullschedule.php?country=#{@country}", :body => @xml)
  end

  it "should get full US schedule" do
    Schedule.full(@country).should == Crack::XML.parse(@xml)["schedule"]
  end
end

end
