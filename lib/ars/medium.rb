require "ars/medium/version"
require 'her'

# @since 0.1.0
module Ars
  # @since 0.1.0
  module Medium

    autoload :Link,        'ars/medium/link'
    autoload :Model,       'ars/medium/model'
    autoload :TestMethods, 'ars/medium/test_methods'

    # @since 0.1.0
    class << self
      attr_accessor :configuration
    end

    # @since 0.1.0
    def self.configuration
      @configuration ||= Configuration.new
    end

    # @since 0.1.0
    def self.configure
      yield configuration
    end

    # @since 0.1.0
    class Configuration
      # @since 0.1.0
      attr_accessor :url, :ssl, :middleware, :root

      # @since 0.1.0
      def initialize
        @url = 'http://localhost/'
        @ssl = {verify: false}
        @middleware = [
          [:request, :multipart],
          [:request, :url_encoded],
          [:use,     Her::Middleware::DefaultParseJSON],
          [:adapter, :net_http_persistent]
        ]
      end

      # @since 0.1.0
      def connection_options
        %i{url ssl}.inject({}) {|hash, key| hash[key] = self.send key ; hash}
      end
    end
  end
end

