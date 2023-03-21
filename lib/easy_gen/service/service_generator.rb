require 'rails/generators'
require 'fileutils'

template_dir = File.expand_path('templates', __dir__)

class ServiceGenerator < Rails::Generators::NamedBase
  # bundle exec rails g service MyService
  # bundle exec rails generate service MyService
  # bundle exec rails d service MyService
  # bundle exec rails delete service MyService
  #

  LOCATION = "services"

  source_root File.expand_path("templates", __dir__)

  def copy_templates
    unless File.exist? "app/#{LOCATION}/application_service.rb"
      template "application_service.rb", "app/#{LOCATION}/application_service.rb"
    end
    template "service.rb", "app/#{LOCATION}/#{file_path}_service.rb"
    template "service_test.rb", "test/#{LOCATION}/#{file_path}_service_test.rb"

    if no_services?
      teardown 'app'
      teardown 'test'
    end
  end

  private

  def no_services?
    Dir["./app/#{LOCATION}/*"].length == 1 && File.exist?("app/#{LOCATION}/application_service.rb") && Dir["./test/#{LOCATION}/*"].length == 0
  end

  def teardown(location)
    FileUtils.rm_rf(Rails.root.join(location,"#{LOCATION}"))
  end
end
