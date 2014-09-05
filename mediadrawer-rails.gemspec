$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mediadrawer/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mediadrawer-rails"
  s.version     = Mediadrawer::Rails::VERSION
  s.authors     = ["Marcelo"]
  s.email       = ["marcelo@tracersoft.com.br"]
  s.summary     = "Mediadrawer is a media library for rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "aws-sdk"
  s.add_dependency "ruby-filemagic"
  s.add_dependency 'jbuilder'
  s.add_dependency "coffee-script"
  s.add_dependency "jquery-rails"
  s.add_dependency "rmagick"
  s.add_dependency "railties"
  s.add_dependency "sass-rails"
  s.add_dependency "font-awesome-sass"
  s.add_dependency "bootstrap-sass"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "mocha"
  s.add_development_dependency "pry"
  s.add_development_dependency "binding_of_caller"
  s.add_development_dependency "better_errors"
end
