module Sofa
  module TVRage
    # This class holds the XML information of a single Show as per the TVRage API.
    # It's also the root point for communicating with the API.
    #
    # @see http://services.tvrage.com/index.php?page=public TVRage API
    class Show
      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'

      class << self
        # Gets the list of all shows
        #
        # @return [Hash] The parsed XML
        # @see http://services.tvrage.com/feeds/show_list.php
        def list
          xml = get('/feeds/show_list.php', query: {})
          xml["shows"]['show']
        end

        # Gets the info for a Show.
        #
        # @param sid [String] The show's id
        # @return [Hash] The parsed XML
        # @see http://services.tvrage.com/feeds/showinfo.php?sid=15614 Chuck's Show Info
        def info(sid)
          xml = get('/feeds/showinfo.php', :query => {:sid => sid})
          xml["Showinfo"]
        end

        # Gets the full show info (info + season list + episode list) for a Show.
        #
        # @param sid [String] The show's id
        # @return [Hash] The parsed XML
        # @see http://services.tvrage.com/feeds/full_show_info.php?sid=15614 Chuck's Full Show Info
        def full_info(sid)
          xml = get('/feeds/full_show_info.php', :query => {:sid => sid})
          xml["Show"]
        end

        # Gets the episode list for a Show.
        #
        # @param sid [String] The show's id
        # @return [Hash] The parsed XML
        # @see http://services.tvrage.com/feeds/episode_list.php?sid=15614 Chuck's Episode List
        def episode_list(sid)
          xml = get('/feeds/episode_list.php', :query => {:sid => sid})
          xml["Show"]
        end

        # Finds the Show by name using TVRage's Quickinfo API.
        #
        # @param name [String] The name of the show to search for
        # @option options [Boolean] :greedy Whether or not to eager load the Season and Episode info
        # @return [Show] The show with id parsed from the Quickinfo search
        # @see http://services.tvrage.com/index.php?page=public&go=quickinfo TVRage Quickinfo API
        # @see http://services.tvrage.com/tools/quickinfo.php?show=Chuck Chuck's Quickinfo
        def by_name(name, options = {})
          html = get('/tools/quickinfo.php', :query => {:show => name}, :format => :html)
          show_info = Crack::XML.parse(html)["pre"]
          raise ShowNotFound unless show_info
          id = show_info.split("\n").first.gsub(%r{^Show ID@}, '').strip
          Show.new(id, options)
        end        
      end

      include Mapping

      # @see Sofa::Mapping
      maps(
        :ended          => nil,
        :showid         => :show_id,
        :showname       => :name,
        :name           => nil,
        :showlink       => :show_link,
        :seasons        => nil,
        :started        => nil,
        :startdate      => :start_date,
        :ended          => nil,
        :origin_country => nil,
        :status         => nil,
        :classification => nil,
        :runtime        => :run_time,
        :network        => nil,
        :airtime        => :air_time,
        :airday         => :air_day,
        :timezone       => :time_zone
      )
      maps(:genres => nil) { |value| value["genre"] }
      maps(:akas => nil) { |value| value["aka"] }

      # Maps :Episodelist to :season_list
      # @see Sofa::Mapping
      # @yieldparam value [Hash, Array] A Hash of info if there's only one. An Array of info if there's multiple
      # @yieldreturn [Array] A list of seasons initialized with value
      maps(:Episodelist => :season_list) do |value|
        case seasons = value["Season"]
        when Hash
          [Season.new(seasons)]
        when Array
          seasons.map { |info| Season.new(info) }
        end
      end

      # Stores all the info that was greedy-loaded
      #
      # @return [Hash] The full show info (including seasons and episodes)
      # @see Show.full_info
      attr_accessor :greedy

      # Returns a new instance of Show, loading and then mapping info from the TVRage API.
      #
      # @param id [String] The show_id as per the TVRage API
      # @option options [Boolean] :greedy Whether or not to eager load the Season and Episode info
      def initialize(id, options = {})
        raise RuntimeError.new("id is required") unless (@show_id = id)
        klass = self.class
        if options[:greedy]
          update_with_mapping(@greedy = klass.full_info(@show_id))
        else
          update_with_mapping(klass.info(@show_id))
        end
      end

      # @return [Array] The list of seasons
      def season_list
        update_with_mapping(self.class.episode_list(@show_id)) unless @season_list
        @season_list
      end

      # @return [Array] The list of episodes
      def episode_list
        season_list.map { |season| season.episodes }.flatten
      end

      class ShowNotFound < RuntimeError #:nodoc:
      end
    end
  end
end
