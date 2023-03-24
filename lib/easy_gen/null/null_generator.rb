require 'rails/all'
require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class NullGenerator < Rails::Generators::NamedBase
  include EasyGenGenerator
  # bundle exec rails g null MyModel
  # bundle exec rails d null MyModel

  LOCATION = "domain"
  TYPE = "null"

  AR_DEFAULTS = {integer: 0,
                 string: '"No Value"',
                 text: '"No Value"',
                 float: 0.0,
                 decimal: 0.0,
                 binary: false,
                 boolean: false,
                 date: 'Date.parse("1 Jan 1970")',
                 datetime: 'Date.parse("1 Jan 1970")',
                 timestamp: 'Date.parse("1 Jan 1970")',
                 time:  'Time.parse("00:00:00")' }

  source_root File.expand_path("templates", __dir__)

  argument :model, type: :string, default: "ERROR",  banner: "model"
  class_option :module, type: :string

  def main
    raise "No such model - please check naming" unless model_exists?
    copy_templates
  end

  private


  def clazz_columns
    clazz.columns_hash.reject { | key, value | key == "id" }
  end

  def clazz
    eg_debug "**** Model: #{model_name} - #{model_name.class} - #{model_name.method(:constantize).source_location} ****"

    model_name.constantize
  end

  def default_value(ar_type)
    return AR_DEFAULTS[ar_type.to_sym]
  end
end
