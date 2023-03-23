require 'rails'
require 'rails/generators'
require 'rails/generators/named_base'
require 'easy_gen'
require 'easy_gen/service/service_generator'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination File.expand_path("../tmp", File.dirname(__FILE__))
  #setup :prepare_destination
end
