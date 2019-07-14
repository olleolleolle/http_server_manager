$LOAD_PATH.push ::File.expand_path("lib", __dir__)
require "http_server_manager/version"

Gem::Specification.new do |spec|
  spec.name = "http_server_manager"
  spec.version = ::HttpServerManager::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = %w{ dueckes techthumb }
  spec.summary = "Manages the lifecycle of HTTP server processes"
  spec.description = "Manages the lifecycle of HTTP server processes"
  spec.email = "matthew.ueckerman@myob.com"
  spec.homepage = "http://github.com/MYOB-Technology/http_server_manager"
  spec.license = "MIT"

  spec.files      = Dir.glob("./lib/**/*") + Dir.glob("./spec/support/**/*")
  spec.test_files = Dir.glob("./spec/**/*")

  spec.require_paths = [ "lib", "spec/support" ]

  spec.required_ruby_version = ">= 2.3"

  spec.add_dependency "sys-proctree", "~> 0.0"
  spec.add_dependency "wait_until",   "~> 0.3"

  spec.add_runtime_dependency "rake", ">= 12.3"

  spec.add_development_dependency "rubocop",     "~> 0.71"
  spec.add_development_dependency "rspec",       "~> 3.8"
  spec.add_development_dependency "simplecov",   "~> 0.16"
  spec.add_development_dependency "rack",        "~> 2.0"
  spec.add_development_dependency "travis-lint", "~> 2.0"
end
