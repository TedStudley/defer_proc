# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'procrastinate/version'

Gem::Specification.new do |spec|
  spec.name          = "procrastinate"
  spec.version       = Procrastinate::VERSION
  spec.authors       = ["tedstudley"]
  spec.email         = ["tedstudley@gmail.com"]

  spec.summary       = %q{Defer execution of a block until certain requirements are met.}
  spec.homepage      = "https://github.com/tedstudley/procrastinate.git"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rdoc-generator-fivefish', '~> 0.1'
  spec.add_development_dependency 'minitest'
end
