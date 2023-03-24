require 'minitest/autorun'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/named_base'
require 'easy_gen'
require 'easy_gen/service/service_generator'
require 'generator_test_helper'

class ServiceGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelper

  tests ServiceGenerator
  destination File.expand_path("../../dummy", File.dirname(__FILE__))

  def setup
    Dir.chdir(dest_dir)
  end


  test "it generates application & service porc  and test script in the right place" do

    assert_no_file "#{dest_dir}/app/services/application_service.rb"
    assert_no_file "#{dest_dir}/app/services/service1_service.rb"
    assert_no_file "#{dest_dir}/test/services/service1_service_test.rb"

    run_generator %w(service1)

    assert_file "#{dest_dir}/app/services/application_service.rb" do |content|
      assert_match(/ApplicationService/, content)
    end
    assert_file "#{dest_dir}/app/services/service1_service.rb"do |content|
      assert_match(/class Service1Service < ApplicationService/, content)
    end
    assert_file "#{dest_dir}/test/services/service1_service_test.rb"do |content|
      assert_match(/class Service1ServiceTest < ActiveSupport::TestCase/, content)
    end
  end

  test "it tidies up destroyed files" do

    easy_gen_ensure "#{dest_dir}/app/services/application_service.rb"
    easy_gen_ensure "#{dest_dir}/app/services/service1_service.rb"
    easy_gen_ensure "#{dest_dir}/test/services/service1_service_test.rb"

    system "#{dest_dir}/bin/rails destroy service service1"

    assert_no_file "#{dest_dir}/app/services/application_service.rb"
    assert_no_file "#{dest_dir}/app/services/service1_service.rb"
    assert_no_file "#{dest_dir}/test/services/service1_service_test.rb"
  end

end
