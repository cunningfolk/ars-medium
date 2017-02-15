require "ars/medium/version"

module Ars
  module Medium

    autoload :Link,        'ars/medium/link'
    autoload :Model,       'ars/medium/model'
    autoload :TestMethods, 'ars/medium/test_methods'

    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    class Configuration
      attr_accessor :url, :ssl, :middleware, :root

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

      def connection_options
        %i{url ssl}.inject({}) {|hash, key| hash[key] = self.send key ; hash}
      end
    end
  end
end

