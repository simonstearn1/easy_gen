# easy_gen : Simple generator to add service class and minitest to rails projects

Save typing when generating service objects in a standard pattern.

Add the following to your Gemfile:

```ruby
gem "easy_gen"
```

Then run

```
bundle install
```

In the usual way.

## Using generators

All you need to do is to run:

```sh
bundle exec rails g service ServiceClassName
```

The command above:

- Creates '/app/services' directory if it doesnt exist.
- Installs new application service class in '/app/services' with the name 'ApplicationService.rb' in file '/app/services/application_service.rb.'
- Installs new service class in '/app/services' with the class name 'ServiceClassName' in the file /app/services/service_class_name.rb.  This will inherit from /app/services/application_services.rb.'
- Creates '/test/services' directory if it doesnt exist.
- Installs new test class in '/app/services' with the name 'ServiceClassNameTest' in the file '/test/services/service_class_name_test.rb'.

** Nothing clever - just saves a bit of typing
