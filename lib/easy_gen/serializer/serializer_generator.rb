require 'rails/all'
require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class SerializerGenerator < Rails::Generators::NamedBase
  include EasyGenGenerator
  # bundle exec rails g null MyModel
  # bundle exec rails d null MyModel

  LOCATION = "serializers"
  TYPE = "serializer"

  source_root File.expand_path("templates", __dir__)

  class_option :module, type: :string

  def main
    copy_templates
  end

  private

end
