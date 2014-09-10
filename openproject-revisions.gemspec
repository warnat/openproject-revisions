# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/revisions/version'
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-revisions"
  s.version     = OpenProject::Revisions::VERSION
  s.authors     = "Oliver Günther"
  s.email       = "mail@oliverguenther.de"
  s.homepage    = "https://www.github.com/oliverguenther/openproject-revisions"
  s.summary     = 'OpenProject Revisions/Base'
  s.description = "This plugin provides a basis for integrating revision control management approaches into OpenProject."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*"] + %w(README.md)

  s.add_dependency "rails", "~> 3.2.14"

end
