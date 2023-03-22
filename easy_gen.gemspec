lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "easy_gen/version"

Gem::Specification.new do |s|
  s.name        = "easy_gen"
  s.version     = EasyGen::VERSION
  s.summary     = "Easy Boilerplate Classes with Minitests!"
  s.description = "A simple generator for some standard design pattern classes and matching minitests."
  s.authors     = ["Simon Stearn"]
  s.email       = "simonstearn@gmail.com"
  s.files       = Dir["lib/**/*", "LICENSE.md", "README.md"]
  s.require_paths = ["lib"]
  s.homepage    = "https://rubygems.org/gems/easy_gen"
  s.metadata    = { "source_code_uri" => "https://github.com/simonstearn1/easy_gen" }
  s.license       = "MIT"
end
