require 'rake'
require 'rake/testtask'

# This gets run when you run `bin/rake` or `bundle exec rake` without specifying a task.
task :default => [:generate_dummy_rails_app, :test]

desc 'generate a rails app inside the test directory to get access to it'
task :generate_dummy_rails_app do
  if File.exist?('test/dummy/config/environment.rb')
    FileUtils.rm_r Dir.glob('test/dummy/')
  end
  system('rails new test/dummy --minimal')
  FileUtils.cp 'test/fixtures/Gemfile', 'test/dummy/'
  system('touch test/dummy/db/schema.rb')
  FileUtils.cp 'test/fixtures/database.yml', 'test/dummy/config/'
  FileUtils.rm_r Dir.glob('test/dummy/test/*') # clobber existing tests
end

desc 'run tests in the test directory, which includes the generated rails app'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
