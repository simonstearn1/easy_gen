require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class DecoratorGenerator < Rails::Generators::NamedBase
  include AbstractGenerator

  # bundle exec rails g service MyService
  # bundle exec rails d service MyService

  LOCATION = "decorators"
  TYPE = "decorator"

  source_root File.expand_path("templates", __dir__)

  argument :model, type: :string, default: "ERROR",  banner: "model"

  def main
    raise "No such model - please check naming" unless model_exists?
    copy_templates
  end

  private

  def model_exists?
    files = Dir[Rails.root + 'app/models/*.rb']
    models = files.map{ |m| File.basename(m, '.rb').camelize }

    models.include? model_name.camelize
  end

  def model_name
    model == "ERROR" ? class_name : model
  end

end
