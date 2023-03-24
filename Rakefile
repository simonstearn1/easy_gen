require 'rake'
require 'rake/testtask'

# This gets run when you run `bin/rake` or `bundle exec rake` without specifying a task.
task :default => [:generate_dummy_rails_app, :generator_testing]

desc 'generate a rails app inside the test directory to get access to it'
task :generate_dummy_rails_app do
  if File.exist?('test/dummy/config/environment.rb')
    FileUtils.rm_r Dir.glob('test/dummy/')
  end
  system('rails new test/dummy --minimal --skip-git')
  FileUtils.cp 'test/fixtures/Gemfile', 'test/dummy/'
  system('touch test/dummy/db/schema.rb')
  FileUtils.cp 'test/fixtures/database.yml', 'test/dummy/config/'
  FileUtils.cp 'test/fixtures/seeds.rb', 'test/dummy/db/'
  system "cd test/dummy && bundle"
  system "cd test/dummy && RAILS_ENV='test' ./bin/rails g model test_thing title:string count:integer"
  system "cd test/dummy && RAILS_ENV='test' ./bin/rails db:migrate"
  system "cd test/dummy && RAILS_ENV='test' ./bin/rails db:seed"
  FileUtils.rm_r Dir.glob('test/dummy/test/*') # clobber new tests
end

desc 'run tests in the test directory, which includes the generated rails app'
Rake::TestTask.new(:generator_testing) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
