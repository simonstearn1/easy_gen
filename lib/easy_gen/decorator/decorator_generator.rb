require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class DecoratorGenerator < Rails::Generators::NamedBase
  include EasyGenGenerator

  # bundle exec rails g service MyService
  # bundle exec rails d service MyService

  LOCATION = "decorators"
  TYPE = "decorator"

  source_root File.expand_path("templates", __dir__)

  argument :model, type: :string, default: "ERROR",  banner: "model"
  class_option :module, type: :string

  def main
    raise "No such model - #{model_name} - in #{model_path} (#{Dir.pwd})- please check naming" unless model_exists?
    copy_templates
  end

end
