$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "er_crm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "er_crm"
  s.version     = ErCrm::VERSION
  s.email = "test@email.com"
  s.authors     = ["EagleRider"]
  s.summary = "Eaglerider CRM."
  s.description = "Eaglerider CRM System."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc", "er_crm.gemspec"] - 
            ["app/models/user.rb", "app/models/region.rb", "app/models/country.rb", "app/models/reservation.rb", "app/models/devise.rb"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '3.2.14'
  s.add_dependency "jquery-rails", "< 3.0.0"
  s.add_dependency "strong_parameters", "~> 0.2.1"
  s.add_dependency "foreigner", "~> 1.5.0"
  s.add_dependency 'audited-activerecord'

  #s.add_development_dependency "sqlite3"
end
