require 'her'
require 'rack/test'

module Ars
  module Medium
    module TestMethods

      def self.app
        @app ||= Rack::Builder.parse_file('server.ru').first
      end

      def stub_api_for(klass)
        klass.use_api( Link.prime!(Medium::configuration) )
      end

      class RackChanneler
        attr_accessor :path_map

        class RHash < Hash
          def [](lookup)
            (find {|rkey,_| lookup =~ rkey } || []).last
          end
        end

        def initialize
          @path_map = RHash.new
        end

        def focus(medium)
          [:collection_path, :resource_path].each do |path|
            path = medium.send(path)
            path_regex = path_regex path
            path_map[path_regex] = { medium: medium, path: path, regex: path_regex }
          end
        end

        def path_regex(path)
          Regexp.new("^/#{path.gsub(/\:([^\/]+)/, '(?<\1>[^\/]+)')}$")
        end

        def call(env)
          [status, headers, body]
        end

        def status
          200
        end

        def headers
          {}
        end

        def body
          []
        end
      end

    end
  end
end

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

  rack_channeler = Ars::Medium::TestMethods::RackChanneler.new

  let(:rack_handle) { rack_channeler }

  media.each do |medium|
    rack_channeler.focus medium
  end

  Ars::Medium.configure do |config|
    config.middleware = [
      [:request,  :multipart],
      [:request,  :url_encoded],
      [:use,      ::Her::Middleware::DefaultParseJSON],
      [:adapter,  :rack, rack_channeler]
    ]
  end

  media.each do |medium|
    before { stub_api_for medium }
  end
end

