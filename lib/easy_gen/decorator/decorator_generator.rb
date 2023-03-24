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

  private

  def model_exists?
    @files ||= Dir[model_path + '*.rb']
    @models ||= @files.map{ |m| File.basename(m, '.rb').camelize }

    @models.include? model_name.camelize
  end

  def model_path
    Pathname(application_root_path.to_s + '/app/models/')
  end

  def model_name
    model == "ERROR" ? class_name : model
  end

end
