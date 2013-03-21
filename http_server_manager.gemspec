# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "./lib/http_server_manager/version"

Gem::Specification.new do |s|
  s.name = "http_server_manager"
  s.version = ::HttpServerManager::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Matthew Ueckerman"]
  s.summary = %q{Manages the lifecycle of HTTP server processes}
  s.description = %q{Manages the lifecycle of HTTP server processes}
  s.email = %q{matthew.ueckerman@myob.com}
  s.homepage = "http://github.com/MYOB-Technology/http_server_manager"
  s.rubyforge_project = "http_server_manager"
  s.license = "MIT"

  s.files      = Dir.glob("./lib/**/*") + Dir.glob("./spec/support/**/*")
  s.test_files = Dir.glob("./spec/**/*")

  s.require_paths = ["lib", "spec/support"]

  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "rake", "~> 10.0.3"
  s.add_dependency "sys-proctree", "~> 0.0.4"
  s.add_dependency "wait_until", "~> 0.0.1"

  s.add_development_dependency "rspec", "~> 2.12"
  s.add_development_dependency "simplecov", "~> 0.7.1"
  s.add_development_dependency "flog", "~> 3.2.2"
  s.add_development_dependency "travis-lint", "~> 1.6.0"
  s.add_development_dependency "rack", "~> 1.5.2"
end
