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

  def gem_testing?
    Rails.root.blank?
  end

  def application_root_path
    gem_testing? ? Pathname.new("./") : Rails.root
  end

  def teardown(places)
    return if (places.blank? || location.blank?)
    places.each do | place |
      FileUtils.rm_rf(application_root_path.join(place,"#{location}"))
    end
  end

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

  def eg_debug(message)
    File.open("/Users/simon/Documents/Personal/Code/easy_gen/tmp/log.txt", "a") do |f|
      f.write message + "\n"
    end
  end

end
