module Ars
  module Medium
    class Link

      class << self
        attr_accessor :default_link
      end

      # def self.prime!(config = Ars::Medium.configuration, opts = {})
      #   @default_link = new(config, opts)
      # end

      def self.prime(config = Ars::Medium.configuration, opts = {})
        @default_link || prime!(config, opts)
      end

      def initialize(config = Ars::Medium.configuration, opts = {})
        prime(config, opts)
      end

      def self.prime!(config = Ars::Medium.configuration, opts = {})

        opts = config.connection_options.merge(opts)

        require 'her'

        @default_link = Her::API.new opts do |c|
          c.ssl.verify = false
          config.middleware.each do |ware|
            c.send *ware
          end
        end
      end
    end
  end
end

