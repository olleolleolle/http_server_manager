# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "http_server_manager/version"

Gem::Specification.new do |spec|
  spec.name = "http_server_manager"
  spec.version = ::HttpServerManager::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Matthew Ueckerman", "Kunal Parikh"]
  spec.summary = "Manages the lifecycle of HTTP server processes"
  spec.description = "Manages the lifecycle of HTTP server processes"
  spec.email = "matthew.ueckerman@myob.com"
  spec.homepage = "http://github.com/MYOB-Technology/http_server_manager"
  spec.rubyforge_project = "http_server_manager"
  spec.license = "MIT"

  spec.files      = Dir.glob("./lib/**/*") + Dir.glob("./spec/support/**/*")
  spec.test_files = Dir.glob("./spec/**/*")

  spec.require_paths = ["lib", "spec/support"]

  spec.required_ruby_version = ">= 2.0"

  spec.add_dependency "sys-proctree", "~> 0.0"
  spec.add_dependency "wait_until",   "~> 0.3"

  spec.add_runtime_dependency "rake", ">= 10.4"

  spec.add_development_dependency "rubocop",     "~> 0.41"
  spec.add_development_dependency "rspec",       "~> 3.5"
  spec.add_development_dependency "simplecov",   "~> 0.12"
  spec.add_development_dependency "rack",        "~> 1.6"
  spec.add_development_dependency "travis-lint", "~> 2.0"
end
