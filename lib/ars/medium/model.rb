require 'her'
require 'ars/familiar/scribe'

module Ars
  module Medium
    # @since 0.1.0
    class Model
      # @since 0.1.0
      def self.filter_root_element(root_element)
        root_element.to_s.sub(/_medium$/, '').to_sym
      end

      # @since 0.1.0
      def self.inherited(subclass)
        subclass.include Her::Model
        subclass.include Ars::Familiar
        subclass.include Ars::Familiar::Scribe

        subclass.use_api Ars::Medium::Link.prime
        subclass.root_element filter_root_element(subclass.root_element)
      end

    end
  end
end

