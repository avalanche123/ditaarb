# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ditaarb/version'

Gem::Specification.new do |spec|
  spec.name          = "ditaarb"
  spec.version       = Ditaa::VERSION
  spec.authors       = ["Bulat Shakirzyanov"]
  spec.email         = ["mallluhuct@gmail.com"]
  spec.summary       = %q{A wrapper around ditaa, to produce images from ascii art}
  spec.description   = %q{A wrapper around ditaa, to produce images from ascii art}
  spec.homepage      = "https://github.com/avalanche123/ditaarb"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb', 'README.md', 'vendor/ditaa0_9.jar']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.requirements << 'java'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
