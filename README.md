[![Gem Version](https://badge.fury.io/rb/easy_gen.svg)][gem]

# easy_gen : Simple generator to add various classes with barebones minitest to rails projects

Save typing when generating certain classes in somewhat standard patterns.

## Installation

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

### Service Object Classes
(See this link for example usage: https://www.honeybadger.io/blog/refactor-ruby-rails-service-object/):

```sh
bundle exec rails g service serviceclassname
```

The command above:

- Creates '/app/services' directory if it doesnt exist.
- Installs new application service class in '/app/services' with the name 'ApplicationService' in file '/app/services/application_service.rb.'
- Installs new service class in '/app/services' with the class name 'ServiceClassName' in the file /app/services/service_class_name.rb.  This will inherit from /app/services/application_services.rb.'
- Creates '/test/services' directory if it doesnt exist.
- Installs new test class in '/test/services' with the name 'ServiceClassNameTest' in the file '/test/services/service_class_name_test.rb'.

### Null Object Classes
(See this link for typical usage: https://medium.com/@kelseydh/using-the-null-object-pattern-with-ruby-on-rails-b645ebf79785 ):

```sh
bundle exec rails g null modelname
```

The command above:

- Creates '/app/domain' directory if it doesnt exist.
- Installs new application domain class in '/app/domain' with the name 'ApplicationNull' in file '/app/domain/application_null.rb.'
- Installs new domain class in '/app/domain' with the class name 'ModelnameNull' in the file /app/domain/modelname_null.rb.  This will inherit from /app/domain/application_null.rb.'
- Creates '/test/domain' directory if it doesnt exist.
- Installs new test class in '/test/domain' with the name 'ModelnameNullTest' in the file '/test/domain/modelname_null_test.rb'.

### Decorator Classes
(See this link for typical usage: https://www.thegreatcodeadventure.com/rails-refactoring-part-iii-the-decorator-pattern/)

```sh
bundle exec rails g decorator modelname
```

The command above:

- Creates '/app/decorators' directory if it doesnt exist.
- Installs new application decorator class in '/app/decorators' with the name 'ApplicationDecorator' in file '/app/decorators/application_decorator.rb.'.  This inherits from Rubys SimpleDelegator class.
- Installs new decorators class in '/app/decorators' with the class name 'ModelnameDecorator' in the file /app/decorators/modelname_decorator.rb.  This will inherit from /app/decorators/application_decorator.rb.'
- Creates '/test/decorators' directory if it doesnt exist.
- Installs new test class in '/test/decorators' with the name 'ModelnameDecoratorTest' in the file '/test/decorators/modelname_decorator_test.rb'.



## Summary
** Nothing clever - just saves a bit of typing
