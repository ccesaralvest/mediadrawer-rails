$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mediadrawer/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mediadrawer-rails"
  s.version     = Mediadrawer::Rails::VERSION
  s.authors     = ["Marcelo"]
  s.email       = ["marcelo@tracersoft.com.br"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Mediadrawer."
  s.description = "TODO: Description of Mediadrawer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.5"

  s.add_development_dependency "sqlite3"
end
