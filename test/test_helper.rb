ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'test/unit'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

end
