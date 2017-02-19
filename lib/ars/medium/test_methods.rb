require 'her'
require 'rack/test'

module Ars
  module Medium
    # @since 0.1.0
    module TestMethods

      # @since 0.1.0
      def self.app
        @app ||= Rack::Builder.parse_file('server.ru').first
      end

      # @since 0.1.0
      def stub_api_for(klass)
        klass.use_api( Link.prime!(Medium::configuration) )
      end

      # @since 0.1.0
      class RackChanneler
        # @since 0.1.0
        attr_accessor :path_map

        # @since 0.1.0
        class RHash < Hash
          # @since 0.1.0
          def [](lookup)
            (find {|rkey,_| lookup =~ rkey } || []).last
          end
        end

        # @since 0.1.0
        def initialize
          @path_map = RHash.new
        end

        # @since 0.1.0
        def focus(medium)
          [:collection_path, :resource_path].each do |path|
            path = medium.send(path)
            path_regex = path_regex path
            path_map[path_regex] = { medium: medium, path: path, regex: path_regex }
          end
        end

        # @since 0.1.0
        def path_regex(path)
          Regexp.new("^/#{path.gsub(/\:([^\/]+)/, '(?<\1>[^\/]+)')}$")
        end

        # @since 0.1.0
        def call(env)
          [status, headers, body]
        end

        # @since 0.1.0
        def status
          200
        end

        # @since 0.1.0
        def headers
          {}
        end

        # @since 0.1.0
        def body
          []
        end
      end

    end
  end
end

# @since 0.1.0
RSpec.configure do |config|
  config.include Ars::Medium::TestMethods, type: :medium
end

RSpec.shared_context "Ars::Medium Rack Stubs" do |*media|
  Ars::Medium.configure do |config|
    config.middleware = [
            [:request,  :multipart],
            [:request,  :url_encoded],
            [:use,      ::Her::Middleware::DefaultParseJSON],
            #[:response, :logger, nil, {bodies: true}],
            [:adapter,  :rack, Ars::Medium::TestMethods.app]
          ]
  end

  media = [*media]
  media.each do |medium|
    before { stub_api_for medium }
  end
end

RSpec.shared_context "Ars::Medium API Stubs" do |*media|
  media = [*media]

  Ars::RACK_CHANNELER ||= Ars::Medium::TestMethods::RackChanneler.new

  let(:rack_handle) { Ars::RACK_CHANNELER }

  media.each do |medium|
    Ars::RACK_CHANNELER.focus medium
  end

  Ars::Medium.configure do |config|
    config.middleware = [
      [:request,  :multipart],
      [:request,  :url_encoded],
      [:use,      ::Her::Middleware::DefaultParseJSON],
      #[:response, :logger, nil, {bodies: true}],
      [:adapter,  :rack, Ars::RACK_CHANNELER]
    ]
  end

  media.each do |medium|
    before { stub_api_for medium }
  end
end

