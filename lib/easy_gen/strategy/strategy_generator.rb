require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class StrategyGenerator < Rails::Generators::NamedBase
  include EasyGenGenerator

  # bundle exec rails g service MyService
  # bundle exec rails d service MyService

  LOCATION = "strategies"
  TYPE = "strategy"

  source_root File.expand_path("templates", __dir__)
  argument :strategies, type: :array, default: [], banner: "strategy strategy.."


  def main
    copy_templates
  end

  private

  def copy_templates
    unless File.exist? "app/#{base_location}/application_#{generator_type}.rb"
      template "application_context.rb", "app/#{base_location}/application_context.rb"
      template "application_#{generator_type}.rb", "app/#{base_location}/application_#{generator_type}.rb"
    end
    template "context.rb", "app/#{location}/#{file_path}_context.rb"
    template "context_test.rb", "test/#{location}/#{file_path}_context_test.rb"

    @parent_strategy = ""
    @strategy = class_name.camelize
    template "#{generator_type}.rb", "app/#{location}/#{class_name.downcase}/#{class_name.downcase}_#{generator_type}.rb"

    @parent_strategy = @strategy
    strategies.each do | strategy |
      @strategy = strategy.camelize
      template "#{generator_type}.rb", "app/#{location}/#{class_name.downcase}/#{strategy.downcase}_#{generator_type}.rb"
      template "#{generator_type}_test.rb", "test/#{location}/#{class_name.downcase}/#{strategy.downcase}_#{generator_type}_test.rb"
    end

    if no_files?
      teardown ['app', 'test']
    end

    if no_files_for_module?
      teardown ['app', 'test']
    end
  end
end
