# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adjutant/version'

Gem::Specification.new do |spec|
  spec.name          = "adjutant"
  spec.version       = Adjutant::VERSION
  spec.authors       = ["Baltazore"]
  spec.email         = ["baltazore92@gmail.com"]
  spec.summary       = %q{Gem that help parse git patch data}
  spec.description   = %q{Ruby Gem that parse patch data for comments and TODO lists and paste them on GitHub PR.}
  spec.homepage      = "baltazore.github.io/adjutant"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json",    "~> 1.7"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "jazz_hands"
end
