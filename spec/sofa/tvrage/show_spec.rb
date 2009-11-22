require 'spec_helper'

module Sofa::TVRage

describe Show do
  before do
    @id = "2930"
    @show_xml = File.read("spec/fixtures/tvrage/show_info.xml")
    FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/showinfo.php?sid=#{@id}", :body => @show_xml)
  end

  describe "with id" do
    subject { Show.new(@id) }

    { :show_id => "2930",
      :show_link => "http://tvrage.com/Buffy_The_Vampire_Slayer",
      :started => "1997",
      :network => "UPN",
      :air_time => "20:00",
      :time_zone => "GMT-5 -DST",
      :run_time => "60",
      :origin_country => "US",
      :air_day => "Tuesday",
      :ended => "May/20/2003",
      :classification => "Scripted",
      :seasons => "7",
      :start_date => "Mar/10/1997",
      :status => "Canceled/Ended",
      :genres => [
        "Action",
        "Adventure",
        "Comedy",
        "Drama",
        "Mystery",
        "Sci-Fi"
      ],
      :name => "Buffy the Vampire Slayer",
      :akas => [
        "Buffy & vampyrerna",
        "Buffy - Im Bann der Dämonen",
        "Buffy - Vampyrenes skrekk",
        "Buffy a vámpírok réme",
        "Buffy Contre les Vampires",
        "Buffy l'Ammazza Vampiri",
        "Buffy postrach wampirów",
        "Buffy, a Caça-Vampiros",
        "Buffy, a Caçadora de Vampiros",
        "Buffy, Cazavampiros",
        "Buffy, ubojica vampira",
        "Buffy, vampyyrintappaja",
        "Vampiiritapja Buffy",
        "Vampírubaninn Buffy"
      ]
    }.each do |attr, value|
      it "should get ##{attr}" do
        subject.send(attr).should == value
      end
    end

    describe "with 1 season" do
      before do
        @episodes_xml = File.read("spec/fixtures/tvrage/episode_list_one_season.xml")
        FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/episode_list.php?sid=#{@id}", :body => @episodes_xml)
        @info = Crack::XML.parse(@episodes_xml)
        @seasons = [Season.new(@info["Show"]["Episodelist"]["Season"])]
      end

      it "should get season_list" do
        subject.season_list.should == @seasons
      end

      it "should get episode_list" do
        subject.episode_list.should == @seasons.map { |season| season.episodes }.flatten
      end
    end

    describe "with multiple seasons" do
      before do
        @episodes_xml = File.read("spec/fixtures/tvrage/episode_list.xml")
        FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/episode_list.php?sid=#{@id}", :body => @episodes_xml)
        @info = Crack::XML.parse(@episodes_xml)
        @seasons = []
        @info["Show"]["Episodelist"]["Season"].each do |season|
          @seasons << Season.new(season)
        end
      end

      it "should get season_list" do
        subject.season_list.should == @seasons
      end

      it "should get episode_list" do
        subject.episode_list.should == @seasons.map { |season| season.episodes }.flatten
      end
    end
  end

  describe "without id" do
    it "should raise error" do
      lambda {
        Show.new(nil)
      }.should raise_error(RuntimeError, "id is required")
    end
  end

  it "should get full show info" do
    @xml = File.read("spec/fixtures/tvrage/full_show_info.xml")
    FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/full_show_info.php?sid=#{@id}", :body => @xml)

    Show.full_info(@id).should == Crack::XML.parse(@xml)["Show"]
  end

  it "should get show by name" do
    @html = File.read("spec/fixtures/tvrage/quickinfo.html")
    @name = "The Colbert Report"
    @id = "6715"
    FakeWeb.register_uri(:get, "http://services.tvrage.com/tools/quickinfo.php?show=#{URI.escape(@name)}", :body => @html)
    FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/showinfo.php?sid=#{@id}", :body => @show_xml)

    Show.by_name(@name).should be_kind_of(Show)
  end

  it "should raise error when get show by missing name" do
    @html = File.read("spec/fixtures/tvrage/quickinfo_missing.html")
    @name = "The Colbert Report"
    FakeWeb.register_uri(:get, "http://services.tvrage.com/tools/quickinfo.php?show=#{URI.escape(@name)}", :body => @html)

    lambda {
      Show.by_name(@name)
    }.should raise_error(Show::ShowNotFound)
  end

  it "should get show by name with options" do
    @html = File.read("spec/fixtures/tvrage/quickinfo.html")
    @name = "The Colbert Report"
    @id = "6715"
    FakeWeb.register_uri(:get, "http://services.tvrage.com/tools/quickinfo.php?show=#{URI.escape(@name)}", :body => @html)
    Show.expects(:new).with(@id, options = mock)

    Show.by_name(@name, options)
  end

  describe "greedy" do
    before do
      @xml = File.read("spec/fixtures/tvrage/full_show_info.xml")
      FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/full_show_info.php?sid=#{@id}", :body => @xml)
    end

    it "should use full show info" do
      Show.expects(:full_info).with(@id).returns({})
      Show.new(@id, :greedy => true)
    end

    it "should use full show info for season list" do
      season_list = Show.new(@id).season_list
      Show.expects(:episode_list).with(@id).never
      Show.new(@id, :greedy => true).season_list.should == season_list
    end
  end
end

end
