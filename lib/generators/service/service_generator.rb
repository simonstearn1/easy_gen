require 'fileutils'

class ServiceGenerator < Rails::Generators::NamedBase
  # bundle exec rails g service MyService
  # bundle exec rails generate service MyService
  # bundle exec rails d service MyService
  # bundle exec rails delete service MyService
  #

  source_root File.expand_path("templates", __dir__)

  def copy_templates
    unless File.exist? "app/services/application_service.rb"
      template "application_service.rb", "app/services/application_service.rb"
    end
    template "service.rb", "app/services/#{file_path}_service.rb"
    template "service_test.rb", "test/services/#{file_path}_service_test.rb"

    if Dir["./app/services/*"].length == 1 && File.exist?("app/services/application_service.rb") && Dir["./test/services/*"].length == 0
      FileUtils.rm_rf(Rails.root.join('test','services'))
      FileUtils.rm_rf(Rails.root.join('app','services'))
    end
  end
end
