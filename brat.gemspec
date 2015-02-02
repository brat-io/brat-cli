# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brat/version'

Gem::Specification.new do |gem|
  gem.name          = "brat"
  gem.version       = Brat::VERSION
  gem.authors       = ["John-Henry Liberty"]
  gem.email         = ["johnhenry.liberty@gmail.com"]
  gem.description   = %q{Ruby client and CLI for Brat.io}
  gem.summary       = %q{A Ruby wrapper and CLI for the Brat.io API}
  gem.homepage      = "https://github.com/jhliberty/brat-cli"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'httparty'
  gem.add_runtime_dependency 'terminal-table'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
end
