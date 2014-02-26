$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "er_crm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "er_crm"
  s.version     = ErCrm::VERSION
  s.email = "test@email.com"
  s.authors     = ["EagleRider"]
  s.summary = "Eaglerider CRM Systedd."
  s.description = "Eaglerider CRM System."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
