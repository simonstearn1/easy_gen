require 'minitest/autorun'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/named_base'
require 'easy_gen'
require 'easy_gen/decorator/decorator_generator'
require 'generator_test_helper'

class DecoratorGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelper

  tests DecoratorGenerator
  destination File.expand_path("../../dummy", File.dirname(__FILE__))

  def setup
    set_dir
  end

  test "it generates application & decorator porc and test script in the right place" do

    assert_no_file "#{dest_dir}/app/decorators/application_decorator.rb"
    assert_no_file "#{dest_dir}/app/decorators/test_thing_decorator.rb"
    assert_no_file "#{dest_dir}/test/decorators/test_thing_decorator_test.rb"

    run_generator %w(test_thing)

    assert_file "#{dest_dir}/app/decorators/application_decorator.rb" do |content|
      assert_match(/ApplicationDecorator < SimpleDelegator/, content)
    end
    assert_file "#{dest_dir}/app/decorators/test_thing_decorator.rb"do |content|
      assert_match(/class TestThingDecorator < ApplicationDecorator/, content)
    end
    assert_file "#{dest_dir}/test/decorators/test_thing_decorator_test.rb"do |content|
      assert_match(/class TestThingDecoratorTest < ActiveSupport::TestCase/, content)
    end
  end

  test "it tidies up destroyed files" do

    easy_gen_ensure "#{dest_dir}/app/decorators/application_decorator.rb"
    easy_gen_ensure "#{dest_dir}/app/decorators/test_thing_decorator.rb"
    easy_gen_ensure "#{dest_dir}/test/decorators/test_thing_decorator_test.rb"

    system "#{dest_dir}/bin/rails destroy decorator test_thing"

    assert_no_file "#{dest_dir}/app/decorators/application_decorator.rb"
    assert_no_file "#{dest_dir}/app/decorators/test_thing_decorator.rb"
    assert_no_file "#{dest_dir}/test/decorators/test_thing_decorator_test.rb"
  end

end
