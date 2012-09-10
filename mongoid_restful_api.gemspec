$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mongoid_restful_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mongoid_restful_api"
  s.version     = MongoidRestfulApi::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MongoidRestfulApi."
  s.description = "TODO: Description of MongoidRestfulApi."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
end
