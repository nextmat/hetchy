# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hetchy/version'

Gem::Specification.new do |spec|
  spec.name          = "hetchy"
  spec.version       = Hetchy::VERSION

  spec.authors       = ["Matt Sanders"]
  spec.email         = ["matt@modal.org"]

  spec.summary       = %q{High performance, thread-safe reservoir sampler with percentile support.}
  spec.description   = %q{A high performance, thread-safe reservoir sampler with snapshot and percentile support.}

  spec.homepage      = "https://github.com/nextmat/hetchy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # spec.add_development_dependency "bundler", "~> 1.7"
  # spec.add_development_dependency "rake", "~> 10.0"
end
