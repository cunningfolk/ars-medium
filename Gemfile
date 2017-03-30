source 'https://rubygems.org'
gemspec

%w[ars-familiar ars-doppelganger ars-terra].each do |lib|
  lib_path = File.expand_path("../../#{lib}", __FILE__)
  lib_path = false unless File.exists? lib_path
  if lib_path
    gem lib, :path => lib_path
  end
end

gem 'bundler', '~> 1.14'
gem 'rake', '~> 12.0'
gem 'rspec', '~> 3.5'

gem 'activemodel'

gem 'gem-release'

gem 'yard', '~> 0.9'
gem 'redcarpet', '~> 3.4'
gem 'github-markup', '~> 1.4'

