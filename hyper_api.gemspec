# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyper_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'hyper_api'
  spec.version       = HyperAPI::VERSION
  spec.summary       = 'Hypertext API. A sweet DSL to create objects off HTML.'
  spec.license       = 'MIT'

  spec.authors       = ['Javier Saldana']
  spec.email         = ['javier@javiersaldana.com']
  spec.homepage      = 'https://github.com/jassa/hyper_api'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
