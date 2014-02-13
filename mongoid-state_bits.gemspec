# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/state_bits/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-state_bits"
  spec.version       = Mongoid::StateBits::VERSION
  spec.authors       = ["Binz"]
  spec.email         = ["xinkiang@gmail.com"]
  spec.summary       = %q{Use one field to generate multiple boolean fields transparently.}
  spec.description   = %q{Merge multiple boolean fields into one field.}
  spec.homepage      = "http://creatist.cn/blog/201308/mongoidstatebits/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "mongoid"
end
