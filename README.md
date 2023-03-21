# easy_gen : Simple generator to add service class and minitest to rails projects

Save typing when generating service objects in a standard pattern.

Add the following to the development group in your Gemfile:

```ruby
gem "easy_gen"
```

Then run

```
bundle install
```

In the usual way.

## Using generators

#Service Objects:

```sh
bundle exec rails g service ServiceClassName
```

The command above:

- Creates '/app/services' directory if it doesnt exist.
- Installs new application service class in '/app/services' with the name 'ApplicationService' in file '/app/services/application_service.rb.'
- Installs new service class in '/app/services' with the class name 'ServiceClassName' in the file /app/services/service_class_name.rb.  This will inherit from /app/services/application_services.rb.'
- Creates '/test/services' directory if it doesnt exist.
- Installs new test class in '/test/services' with the name 'ServiceClassNameTest' in the file '/test/services/service_class_name_test.rb'.

#Null Objects (See this link for typical usage https://medium.com/@kelseydh/using-the-null-object-pattern-with-ruby-on-rails-b645ebf79785 ):

```sh
bundle exec rails g null modelname
```

The command above:

- Creates '/app/domain' directory if it doesnt exist.
- Installs new application domain class in '/app/domain' with the name 'ApplicationNull' in file '/app/domain/application_null.rb.'
- Installs new domain class in '/app/domain' with the class name 'NullModelname' in the file /app/domain/null_modelname.rb.  This will inherit from /app/domain/application_null.rb.'
- Creates '/test/domain' directory if it doesnt exist.
- Installs new test class in '/test/domain' with the name 'ServiceClassNameTest' in the file '/test/domain/null_modelname_test.rb'.


** Nothing clever - just saves a bit of typing
