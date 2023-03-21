require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class NullGenerator < Rails::Generators::NamedBase
  # bundle exec rails g null MyModel
  # bundle exec rails d null MyModel
  #

  LOCATION = "domain"

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

  def copy_templates
    unless File.exist? "app/#{LOCATION}/application_service.rb"
      template "application_null.rb", "app/#{LOCATION}/application_null.rb"
    end
    template "null.rb", "app/#{LOCATION}/null_#{file_path}.rb"
    template "null_test.rb", "test/#{LOCATION}/null_#{file_path}_test.rb"

    if no_files?
      teardown ['app', 'test']
    end
  end

  private

  def no_files?
    Dir["./app/#{LOCATION}/*"].length == 1 && File.exist?("app/#{LOCATION}/application_null.rb") && Dir["./test/#{LOCATION}/*"].length == 0
  end

  def teardown(places)
    print "Removing:"
    places.each do | location |
      print location + " "
      FileUtils.rm_rf(Rails.root.join(location,"#{LOCATION}"))
    end
    puts "."
  end

  def model_name
    model == "ERROR" ? class_name : model
  end

  def clazz
    Kernel.const_get(model_name)
  end

  def default_value(ar_type)
    return AR_DEFAULTS[ar_type.to_sym]
  end

  def clazz_columns
    clazz.columns_hash.reject { | key, value | key == "id" }
  end
end
