# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uploadify-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "uploadify-rails"
  gem.version       = Uploadify::Rails::VERSION
  gem.authors       = ["Filip Tepper"]
  gem.email         = ["filip@tepper.pl"]
  gem.description   = %q{Uploadify plugin for Ruby on Rails asset pipeline}
  gem.summary       = %q{Uploadify plugin for Ruby on Rails asset pipeline}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
