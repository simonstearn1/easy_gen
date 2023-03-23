require 'rails/generators'
require 'fileutils'

module EasyGenGenerator

  def copy_templates
    unless File.exist? "app/#{base_location}/application_#{generator_type}.rb"
      template "application_#{generator_type}.rb", "app/#{base_location}/application_#{generator_type}.rb"
    end
    template "#{generator_type}.rb", "app/#{location}/#{file_path}_#{generator_type}.rb"
    template "#{generator_type}_test.rb", "test/#{location}/#{file_path}_#{generator_type}_test.rb"

    if no_files?
      teardown ['app', 'test']
    end

    if no_files_for_module?
      teardown ['app', 'test']
    end
  end

  private

  def module?
    options[:module].present?
  end

  def module_name
    @module_name ||= module? ? options[:module] : ""
  end

  def module_prefix
    @module_prefix ||= module? ? "#{module_name.camelize}::" : ""
  end

  def module_dir
    @module_dir ||= module? ? "/#{module_name.downcase}" : ""
  end

  def base_location
    @base_location ||= self.class::LOCATION
  end

  def location
    @location ||= base_location + module_dir
  end

  def generator_type
    @generator_type ||= self.class::TYPE
  end

  def no_files?
    only_one_file? && file_is_abstract_class? && no_tests?
  end

  def only_one_file?
    Dir["./app/#{base_location}/**/*"].reject { | path | File.directory?(path) }.length == 1
  end

  def file_is_abstract_class?
    File.exist?("app/#{base_location}/application_#{generator_type}.rb")
  end

  def no_tests?
    Dir["./test/#{base_location}/**/*"].reject { | path | File.directory?(path) }.length == 0
  end

  def no_files_for_module?
    no_app_files_for_module? && no_test_files_for_module?
  end

  def no_test_files_for_module?
    Dir["./test/#{location}/**/*"].reject { | path | File.directory?(path) }.length == 0
  end

  def no_app_files_for_module?
    Dir["./app/#{location}/**/*"].reject { | path | File.directory?(path) }.length == 0
  end

  def teardown(places)
    return if (places.blank? || location.blank? || Rails.root.blank?)
    puts "places:#{places}."
    print "Removing directories: "
    places&.each do | place |
      print place + '/' + location + " "
      FileUtils.rm_rf(Rails.root.join(place,"#{location}"))
    end
    puts "- done"
  end

end
