# -*- encoding: utf-8 -*-
require File.expand_path('../lib/clerk/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Beekman"]
  gem.email         = ["robert@80beans.com"]
  gem.description   = %q{A simple logger for mongoid}
  gem.summary       = %q{A simple logger for mongoid}
  gem.homepage      = "http://github.com/80beans/mongoid-clerk"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongoid-clerk"
  gem.require_paths = ["lib"]
  gem.version       = Clerk::VERSION

  gem.add_dependency 'mongoid'
  gem.add_dependency 'bson_ext'
  gem.add_dependency 'rspec'
  gem.add_dependency 'mongoid-rspec'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'rake'
  gem.add_dependency 'foreman'
end
