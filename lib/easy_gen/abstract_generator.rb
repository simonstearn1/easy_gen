require 'rails/generators'
require 'fileutils'

module AbstractGenerator

  def copy_templates
    unless File.exist? "app/#{location}/application_#{generator_type}.rb"
      template "application_#{generator_type}.rb", "app/#{location}/application_#{generator_type}.rb"
    end
    template "#{generator_type}.rb", "app/#{location}/#{file_path}_#{generator_type}.rb"
    template "#{generator_type}_test.rb", "test/#{location}/#{file_path}_#{generator_type}_test.rb"

    if no_files?
      teardown ['app', 'test']
    end
  end

  private

  def location
    self.class::LOCATION
  end

  def generator_type
    self.class::TYPE
  end

  def no_files?
    Dir["./app/#{location}/*"].length == 1 && File.exist?("app/#{location}/application_#{generator_type}.rb") && Dir["./test/#{location}/*"].length == 0
  end

  def teardown(places)
    print "Removing:"
    places.each do | place |
      print place + " "
      FileUtils.rm_rf(Rails.root.join(place,"#{location}"))
    end
    puts "- done"
  end

end
