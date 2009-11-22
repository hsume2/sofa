module Sofa
  module TVRage
    # This class holds the XML information of a single season as per the TVRage API.
    #
    # @see http://services.tvrage.com/index.php?page=public TVRage API : Episode List
    class Season
      include Mapping

      # Maps :no to itself
      # @see Sofa::Mapping
      maps(:no => nil)
      
      # Maps :episode to :episodes
      # @see Sofa::Mapping
      # @yieldparam value [Hash, Array] A Hash of info if there's only one. An Array of info if there's multiple
      # @yieldreturn [Array] A list of episodes initialized with value
      maps(:episode => :episodes) do |value|
        case value
        when Hash
          [Episode.new(value)]
        when Array
          value.map { |info| Episode.new(info) }
        end
      end

      # Returns a new instance of Season, mapping info from the TVRage API
      #
      # @param info [Hash<Symbol, Object>] Info to initialize with
      # @option info [String] :no The season number
      # @option info [String] :episode The collection of episodes
      def initialize(info)
        update_with_mapping(info)
      end
    end
  end
end
