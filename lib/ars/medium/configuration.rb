require 'her'

module Ars
  module Medium
    # @since 0.1.0
    class Configuration
      include Ars::AttachedConfig

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
