require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class ServiceGenerator < Rails::Generators::NamedBase
  include EasyGenGenerator

  # bundle exec rails g service MyService
  # bundle exec rails d service MyService

  LOCATION = "services"
  TYPE = "service"

  source_root File.expand_path("templates", __dir__)

  class_option :module, type: :string

  def main
    copy_templates
  end

end
