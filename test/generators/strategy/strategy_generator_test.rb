require 'minitest/autorun'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/named_base'
require 'easy_gen'
require 'easy_gen/strategy/strategy_generator'
require 'generator_test_helper'

class StrategyGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelper

  tests StrategyGenerator
  destination File.expand_path("../../dummy", File.dirname(__FILE__))

  def setup
    set_dir
  end


  test "it generates application, context & strategy porc and test scripts in the right place" do

    assert_no_file "#{dest_dir}/app/strategies/application_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/application_context.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing_context.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/fishing_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/hook_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/line_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/net_strategy.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing_context_test.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing/hook_strategy_test.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing/line_strategy_test.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing/net_strategy_test.rb"

    run_generator %w(fishing hook line net)

    assert_file "#{dest_dir}/app/strategies/application_strategy.rb" do |content|
      assert_match(/ApplicationStrategy/, content)
    end
    assert_file "#{dest_dir}/app/strategies/fishing/fishing_strategy.rb"do |content|
      assert_match(/class Fishing::FishingStrategy < ApplicationStrategy/, content)
    end
    assert_file "#{dest_dir}/app/strategies/fishing/hook_strategy.rb"do |content|
      assert_match(/class Fishing::HookStrategy < Fishing::FishingStrategy/, content)
    end
    assert_file "#{dest_dir}/app/strategies/fishing/line_strategy.rb"do |content|
      assert_match(/class Fishing::LineStrategy < Fishing::FishingStrategy/, content)
    end
    assert_file "#{dest_dir}/app/strategies/fishing/net_strategy.rb"do |content|
      assert_match(/class Fishing::NetStrategy < Fishing::FishingStrategy/, content)
    end
    assert_file "#{dest_dir}/test/strategies/fishing_context_test.rb"do |content|
      assert_match(/class FishingContextTest < ActiveSupport::TestCase/, content)
    end
  end

  test "it tidies up destroyed files" do

    easy_gen_ensure "#{dest_dir}/app/strategies/application_strategy.rb"
    easy_gen_ensure "#{dest_dir}/app/strategies/application_context.rb"
    easy_gen_ensure "#{dest_dir}/app/strategies/fishing_context.rb"
    easy_gen_ensure "#{dest_dir}/app/strategies/fishing/fishing_strategy.rb"
    easy_gen_ensure "#{dest_dir}/app/strategies/fishing/hook_strategy.rb"
    easy_gen_ensure "#{dest_dir}/app/strategies/fishing/line_strategy.rb"
    easy_gen_ensure "#{dest_dir}/app/strategies/fishing/net_strategy.rb"
    easy_gen_ensure "#{dest_dir}/test/strategies/fishing_context_test.rb"
    easy_gen_ensure "#{dest_dir}/test/strategies/fishing/hook_strategy_test.rb"
    easy_gen_ensure "#{dest_dir}/test/strategies/fishing/line_strategy_test.rb"
    easy_gen_ensure "#{dest_dir}/test/strategies/fishing/net_strategy_test.rb"

    system "#{dest_dir}/bin/rails destroy strategy fishing hook line net"

    assert_no_file "#{dest_dir}/app/strategies/fishing_context.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/fishing_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/hook_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/line_strategy.rb"
    assert_no_file "#{dest_dir}/app/strategies/fishing/net_strategy.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing_context_test.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing/hook_strategy_test.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing/line_strategy_test.rb"
    assert_no_file "#{dest_dir}/test/strategies/fishing/net_strategy_test.rb"
  end

end
