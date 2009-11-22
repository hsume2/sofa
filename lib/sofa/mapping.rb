module Sofa
  module Mapping
    # This method is automatically called when {Mapping} is included in a module.
    # It automatically adds {InstanceMethods}, {ClassMethods}
    # and initializes @mappings and @mappings_procs to empty Hashes.
    #
    # @param base [Module, Class] The module that this is included in
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
      base.instance_variable_set("@mappings", {})
      base.instance_variable_set("@mappings_procs", {})
    end

    module InstanceMethods
      # Returns hash of all the attributes, with attribute names as keys and attribute values as values.
      #
      # @return [Hash<Symbol, Object>] Hash of all attributes
      # @see Sofa::Mapping::ClassMethods#maps
      def attributes
        klass = self.class
        klass.mappings.values.inject({}) do |attrs, to|
          next unless to
          attrs[to] = send(to)
          attrs
        end
      end

      # Updates all the attributes from the Hash.
      #
      # @param attributes [Hash<Symbol, Object>] A hash with attribute names as keys and attribute values as values
      # @see Sofa::Mapping::ClassMethods#maps
      def update_with_mapping(attributes = {})
        attributes.each do |key, value|
          next unless (klass = self.class) and key.respond_to?(:to_sym) and to = klass.mappings[key.to_sym]

          block = klass.mappings_procs[to]
          value = block.call(value) if block

          instance_variable_set("@#{to}", value)
        end
      end

      # Compares two objects based on their attributes.
      #
      # @param obj [Object] The object to compare with
      # @return [Boolean] Whether all attributes are the same
      def ==(obj)
        if (klass = self.class) == obj.class
          klass.mappings.inject(true) do |result, to_from|
            to = to_from.last || to_from.first
            result &&= (obj.send(to) == self.send(to))
          end
        else
          super
        end
      end
    end

    module ClassMethods
      # Class method to define mappings.
      # 
      # @example Maps :examplename to :name and :link to itself.
      #   class Example1
      #     include Sofa::Mapping
      #     maps(
      #       :examplename => :name,
      #       :link        => nil
      #     )
      #   end
      #   example1 = Example1.new.update_with_mapping(:epnum => "1", :link => "http://google.com")
      #   example1.name       # => "1"
      #   example1.link       # => "http://google.com"
      #   example1.attributes # => {:name => "1", :link => "http://google.com"}
      # @example Maps :airdate to :air_date and stores the block.
      #   class Example2
      #     include Sofa::Mapping
      #
      #     maps(:airdate => :air_date) do |value|
      #       Date.parse(value)
      #     end
      #   end
      #   example2 = Example2.new.update_with_mapping(:airdate => "2007-07-04")
      #   example2.attributes # => {:air_date => Wed, 04 Jul 2007}
      def maps(hash = {}, &block)
        hash.each do |from, to|
          method = to || from
          @mappings[from.to_sym] = method
          attr_reader method
          @mappings_procs[method] = block
        end
      end

      # @private
      # @return [Hash<Symbol, Symbol>] Mapping of symbols to attribute names
      def mappings #:nodoc:
        @mappings
      end

      # @private
      # @return [Hash<Symbol, Proc>] Mapping of attribute names to a Proc filter.
      # @see #maps
      def mappings_procs #:nodoc:
        @mappings_procs
      end
    end
  end
end
