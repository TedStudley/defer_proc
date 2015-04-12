# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'defer/version'

Gem::Specification.new do |spec|
  spec.name          = "defer"
  spec.version       = Defer::VERSION
  spec.authors       = ["tedstudley"]
  spec.email         = ["tedstudley@gmail.com"]

  spec.summary       = %q{Defer execution of a block until certain requirements are met.}
  spec.homepage      = "https://github.com/tedstudley/defer.git"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  #end

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rdoc-generator-fivefish', '~> 0.1'
  spec.add_development_dependency 'minitest'
end
