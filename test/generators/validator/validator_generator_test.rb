require 'minitest/autorun'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/named_base'
require 'easy_gen'
require 'easy_gen/validator/validator_generator'
require 'generator_test_helper'

class ValidatorGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelper

  tests ValidatorGenerator
  destination File.expand_path("../../dummy", File.dirname(__FILE__))

  def setup
    set_dir
  end


  test "it generates application & validator porc  and test script in the right place" do

    assert_no_file "#{dest_dir}/app/validators/application_validator.rb"
    assert_no_file "#{dest_dir}/app/validators/validator1_validator.rb"
    assert_no_file "#{dest_dir}/test/validators/validator1_validator_test.rb"

    run_generator %w(basic)

    assert_file "#{dest_dir}/app/validators/application_validator.rb" do |content|
      assert_match(/ApplicationValidator < ActiveModel::EachValidator/, content)
    end
    assert_file "#{dest_dir}/app/validators/basic_validator.rb"do |content|
      assert_match(/class BasicValidator < ApplicationValidator/, content)
    end
    assert_file "#{dest_dir}/test/validators/basic_validator_test.rb"do |content|
      assert_match(/class BasicValidatorTest < ActiveSupport::TestCase/, content)
    end
  end

  test "it tidies up destroyed files" do

    easy_gen_ensure "#{dest_dir}/app/validators/application_validator.rb"
    easy_gen_ensure "#{dest_dir}/app/validators/basic_validator.rb"
    easy_gen_ensure "#{dest_dir}/test/validators/basic_validator_test.rb"

    system "#{dest_dir}/bin/rails destroy validator basic"

    assert_no_file "#{dest_dir}/app/validators/application_validator.rb"
    assert_no_file "#{dest_dir}/app/validators/basic_validator.rb"
    assert_no_file "#{dest_dir}/test/validators/basic_validator_test.rb"
  end

end
