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
    Dir.chdir(dest_dir)
    unless File.exist?("#{dest_dir}/app/models/thing.rb")
      system "./bin/rails g model thing title:string count:integer"
      system "RAILS_ENV='test' ./bin/rails db:migrate"
    end
  end

  test "it generates application & decorator porc and test script in the right place" do

    assert_no_file "#{dest_dir}/app/decorators/application_decorator.rb"
    assert_no_file "#{dest_dir}/app/decorators/thing_decorator.rb"
    assert_no_file "#{dest_dir}/test/decorators/thing_decorator_test.rb"

    run_generator %w(thing)

    assert_file "#{dest_dir}/app/decorators/application_decorator.rb" do |content|
      assert_match(/ApplicationDecorator < SimpleDelegator/, content)
    end
    assert_file "#{dest_dir}/app/decorators/thing_decorator.rb"do |content|
      assert_match(/class ThingDecorator < ApplicationDecorator/, content)
    end
    assert_file "#{dest_dir}/test/decorators/thing_decorator_test.rb"do |content|
      assert_match(/class ThingDecoratorTest < ActiveSupport::TestCase/, content)
    end
  end

  test "it tidies up destroyed files" do

    easy_gen_ensure "#{dest_dir}/app/decorators/application_decorator.rb"
    easy_gen_ensure "#{dest_dir}/app/decorators/thing_decorator.rb"
    easy_gen_ensure "#{dest_dir}/test/decorators/thing_decorator_test.rb"

    system "#{dest_dir}/bin/rails destroy decorator thing"

    assert_no_file "#{dest_dir}/app/decorators/application_decorator.rb"
    assert_no_file "#{dest_dir}/app/decorators/thing_decorator.rb"
    assert_no_file "#{dest_dir}/test/decorators/thing_decorator_test.rb"
  end

end
