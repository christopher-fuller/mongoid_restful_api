$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mongoid_restful_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mongoid_restful_api"
  s.version     = MongoidRestfulApi::VERSION
  s.authors     = ["Christopher Fuller"]
  s.email       = ["git@chrisfuller.me"]
  s.homepage    = "http://github.com/chrisfuller/mongoid_restful_api"
  s.summary     = "A gem that simplifies the creation of restful APIs backed by MongoDB via the Mongoid ODM.\nDefining models and/or controllers in Rails is optional during development."
  s.description = "A gem that simplifies the creation of restful APIs backed by MongoDB via the Mongoid ODM.\nDefining models and/or controllers in Rails is optional during development."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"   , "~> 3.2"
  s.add_dependency "mongoid" , "~> 3.0"
end
