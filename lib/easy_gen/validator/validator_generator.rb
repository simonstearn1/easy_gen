require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class ValidatorGenerator < Rails::Generators::NamedBase
  include EasyGenGenerator

  # bundle exec rails g service MyService
  # bundle exec rails d service MyService

  LOCATION = "validators"
  TYPE = "validator"

  source_root File.expand_path("templates", __dir__)

  def main
    copy_templates
  end

  private

end
