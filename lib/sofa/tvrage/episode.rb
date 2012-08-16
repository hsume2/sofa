module Sofa
  module TVRage
    # This class holds the XML information of a single episode as per the TVRage API.
    #
    # @see http://services.tvrage.com/index.php?page=public TVRage API : Episode List
    class Episode
      include Mapping

      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'

      class << self
        # Gets the info for a Episode.
        #
        # @param sid [String] The show's id
        # @return [Hash] The parsed XML
        # @see http://services.tvrage.com/feeds/episodeinfo.php?sid=2930&ep=2x04
        def info(sid, season_no, ep_num)
          xml = get('/feeds/episodeinfo.php', :query => {:sid => sid, :ep => "#{season_no}x#{ep_num}"})
          xml["show"]
        end
      end


      # @see Sofa::Mapping
      maps(
        :epnum     => :num,
        :seasonnum => :num_in_season,
        :prodnum   => :prod_num,
        :airdate   => :air_date,
        :link      => nil,
        :title     => nil
      )

      # The season number of the Season this Episode belongs to.
      # Not actually a part of the TVRage API, but it's used to inject
      # the +season_num+ when looping through Episodes in a Season.
      attr_reader :season_num

      # Returns a new instance of Episode, mapping info from the TVRage API
      #
      # @param info [Hash<Symbol, Object>] Info to initialize with
      # @option info [String] :epnum The episode number in the context of all episodes
      # @option info [String] :seasonnum The episode number in the context of its season
      # @option info [String] :prodnum
      # @option info [String] :airdate The date the episode airs
      # @option info [String] :link The TVRage page for this Episode
      # @option info [String] :title The title of this Episode
      # @option info [String] :season_num The season number of the Season this Episode belongs to
      def initialize(info)
        update_with_mapping(info)
      end
    end
  end
end
