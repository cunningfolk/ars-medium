source 'https://rubygems.org'

# Specify your gem's dependencies in ars-medium.gemspec
gemspec

gem 'rake'
gem 'bundler'#, '~> 1.14'
gem 'rspec'#, '~> 3.0'

gem 'yard', require: false

%w[ars-familiar ars-doppelganger].each do |lib|
  lib_path = File.expand_path("../../#{lib}", __FILE__)
  lib_path = false unless File.exists? lib_path
  if lib_path
    gem lib, :path => lib_path
  end
end

eval File.read('Gemfile.local') if File.exist?('Gemfile.local')
