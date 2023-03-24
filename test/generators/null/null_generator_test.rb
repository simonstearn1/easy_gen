require 'minitest/autorun'
require 'rails/all'
#require 'rails/generators'
#require 'rails/generators/named_base'
require 'easy_gen'
require 'easy_gen/null/null_generator'
require 'generator_test_helper'

class NullGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelper

  tests NullGenerator
  destination File.expand_path("../../dummy", File.dirname(__FILE__))

  def setup
    set_dir
  end

  test "it generates application & null porc and test script in the right place" do

    assert_no_file "#{dest_dir}/app/domain/application_null.rb"
    assert_no_file "#{dest_dir}/app/domain/test_thing_null.rb"
    assert_no_file "#{dest_dir}/test/domain/test_thing_null_test.rb"

    system "RAILS_ENV='test' #{dest_dir}/bin/rails generate null test_thing"

    assert_file "#{dest_dir}/app/domain/application_null.rb" do |content|
      assert_match(/ApplicationNull/, content)
    end
    assert_file "#{dest_dir}/app/domain/test_thing_null.rb"do |content|
      assert_match(/class TestThingNull < ApplicationNull/, content)
    end
    assert_file "#{dest_dir}/test/domain/test_thing_null_test.rb"do |content|
      assert_match(/class TestThingNullTest < ActiveSupport::TestCase/, content)
    end
  end

  test "it tidies up when destroyed files" do

    easy_gen_ensure "#{dest_dir}/app/domain/application_null.rb"
    easy_gen_ensure "#{dest_dir}/app/domain/test_thing_null.rb"
    easy_gen_ensure "#{dest_dir}/test/domain/test_thing_null_test.rb"

    system "RAILS_ENV='test' #{dest_dir}/bin/rails destroy null test_thing"

    assert_no_file "#{dest_dir}/app/domain/application_null.rb"
    assert_no_file "#{dest_dir}/app/domain/test_thing_null.rb"
    assert_no_file "#{dest_dir}/test/domain/test_thing_null_test.rb"
  end

end
