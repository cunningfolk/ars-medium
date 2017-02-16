# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ars/medium/version'

Gem::Specification.new do |spec|
  spec.name          = "ars-medium"
  spec.version       = Ars::Medium::VERSION
  spec.authors       = ["Michael Lee Vazquez"]
  spec.email         = ["magnus.nothus@gmail.com"]

  spec.summary       = %q{ars-medium-#{Ars::Medium::VERSION}}
  spec.description   = %q{Ruby Web Client that syncs with most models}
  spec.homepage      = "http://github.com/cunningfolk/ars-medium"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  %w[familiar doppelganger].each do |lib_name|
    if Ars::Medium::VERSION =~ /[a-zA-Z]+/
      spec.add_runtime_dependency "ars-#{lib_name}", "= #{Ars::Medium::VERSION}"
    else
      spec.add_runtime_dependency "ars-#{lib_name}", "~> #{Ars::Medium::VERSION.sub(/^((?:\d+\.){2}).*$/, '\10')}"
    end
  end

  spec.add_runtime_dependency 'her', '>= 0', '>= 0'
  spec.add_runtime_dependency 'rack-test', '>= 0', '>= 0'

end
