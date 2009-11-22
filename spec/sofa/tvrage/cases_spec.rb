require 'spec_helper'

if ENV["CASES"]

describe "Cases" do
  Dir["spec/fixtures/tvrage/cases/*.xml"].each do |file|
    describe "with #{file}" do
      before do
        @id = "22323"
        @show_xml = File.read(file)
        FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/full_show_info.php?sid=#{@id}", :body => @show_xml)
      end

      it "should not raise error" do
        lambda {
          show = Sofa::TVRage::Show.new(@id, :greedy => true)
          show.episode_list.should_not include(nil)
        }.should_not raise_error
      end

      it "should have name" do
        show = Sofa::TVRage::Show.new(@id, :greedy => true)
        show.name.should_not be_nil
      end
    end
  end
end

end
