# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'helloworld/version'

Gem::Specification.new do |spec|
  spec.name          = 'helloworld'
  spec.version       = Helloworld::VERSION
  spec.authors       = ['kse201']
  spec.email         = ['kse.201@gmail.com']

  spec.summary       = 'Hello World'
  spec.description   = 'Hello World app'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'cucumber', '~> 2.4.0'
  spec.add_development_dependency 'simplecov', '~> 0.13.0'

  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-cucumber'
  spec.add_development_dependency 'guard-rubocop'
end
