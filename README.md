[![Gem Version](https://badge.fury.io/rb/easy_gen.svg)](https://badge.fury.io/rb/easy_gen)

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

### Service Classes
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

optionally run with the module option to embed within a module namespace.  For example:

```sh
bundle exec rails g service serviceclassname --module cool
```

- Creates '/app/services/cool' directory if it doesnt exist.
- Installs new application service class in '/app/services' with the name 'ApplicationService' in file '/app/services/application_service.rb.'
- Installs new service class in '/app/services/cool' with the class name 'Cool::ServiceClassName' in the file /app/services/cool/service_class_name.rb.  This will inherit from /app/services/application_services.rb.'
- Creates '/test/services/cool' directory if it doesnt exist.
- Installs new test class in '/test/services/cool' with the name 'ServiceClassNameTest' in the file '/test/services/cool/service_class_name_test.rb'.

### Validator Classes
(See this link for example usage: https://womanonrails.com/custom-rails-validators ):

```sh
bundle exec rails g validator target
```

The command above:

- Creates '/app/validators' directory if it doesnt exist.
- Installs new application validator class in '/app/validator' with the name 'ApplicationValidator' in file '/app/services/application_validator.rb.' which inherits from ActiveModel::EachValidator.
- Installs new validator class in '/app/validators' with the class name 'TargetValidator' in the file /app/validators/target_validator.rb.  This will inherit from /app/services/application_validator.rb.'
- Creates '/test/validators' directory if it doesnt exist.
- Installs new test class in '/test/validators' with the name 'TargetValidatorTest' in the file '/test/validators/target_validator_test.rb'.

Yeah I know there are other types of validators - pull requests gratefully received.  I have only ever used EachValidators, and them many times..

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
- Installs new test class in '/test/domain' with the name 'ModelnameNullTest' in the file '/test/domain/modelname_null_test.rb'. Tests include 'stubbing' of all model 'columns' based on data type, with assertions (coverage baby).

Module option is also supported.

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


Module option is also supported.

### Strategy Classes
(See this link for typical usage: https://refactoring.guru/design-patterns/strategy/ruby/example)

```sh
bundle exec rails g strategy context strategy1 strategy2 ...
```


Example:

```sh
bundle exec rails g strategy fishing hook line net
```

The command above:

- Creates '/app/strategies' directory if it doesnt exist.
- Creates '/app/strategies/fishing' directory if it doesnt exist.
- Installs new application context class in '/app/strategies' with the name 'ApplicationContext' in file '/app/strategies/application_context.rb.'.
- Installs new application strategy class in '/app/strategies' with the name 'ApplicationStrategy' in file '/app/strategies/application_strategy.rb.'.
- Installs new context module and class in '/app/strategies' with the class name 'Fishing::Context' in the file /app/strategies/fishing_context.rb.  This will inherit from /app/strategies/application_context.rb.'
- Installs new strategy class in '/app/strategies/fishing' with the class name 'Fishing::FishingStrategy' in the file /app/strategies/fishing/fishing_strategy.rb.  This will inherit from /app/strategies/application_strategy.rb.'
- Installs new strategy class in '/app/strategies/fishing' with the class name 'Fishing::HookStrategy' in the file /app/strategies/fishing/hook_strategy.rb.  This will inherit from /app/strategies/fishing/fishing_strategy.rb.'
- Installs new strategy class in '/app/strategies/fishing' with the class name 'Fishing::LineStrategy' in the file /app/strategies/fishing/line_strategy.rb.  This will inherit from /app/strategies/fishing/fishing_strategy.rb.'
- Installs new strategy class in '/app/strategies/fishing' with the class name 'Fishing::NetStrategy' in the file /app/strategies/fishing/net_strategy.rb.  This will inherit from /app/strategies/fishing/fishing_strategy.rb.'
- Creates '/test/strategies' directory if it doesnt exist.
- Creates '/test/strategies/fishing' directory if it doesnt exist.
- Installs new test class in '/test/strategies' with the name 'FishingContext' in the file '/test/strategies/fishing_context_test.rb'.
- Installs new test class in '/test/strategies/fishing' with the name 'FishingStrategy' in the file '/test/strategies/fishing_strategy_test.rb'.
- Installs new test class in '/test/strategies/fishing' with the name 'HookStrategy' in the file '/test/strategies/hook_strategy_test.rb'.
- Installs new test class in '/test/strategies/fishing' with the name 'LineStrategy' in the file '/test/strategies/line_strategy_test.rb'.
- Installs new test class in '/test/strategies/fishing' with the name 'NetStrategy' in the file '/test/strategies/net_strategy_test.rb'.

### Serializer Classes
If you want to do something other than standard JSON serialization...

```sh
bundle exec rails g serializer basic
```

The command above:

- Creates '/app/serializers' directory if it doesnt exist.
- Installs new application serializer class in '/app/serializers' with the name 'ApplicationSerializer' in file '/app/decorators/application_serializer.rb.'.
- Installs new serializer class in '/app/serializer' with the class name 'BasicSerializer' in the file /app/decorators/basic_seralizer.rb.  This will inherit from /app/decorators/application_serializer.rb.'
- Creates '/test/serializers' directory if it doesnt exist.
- Installs new test class in '/test/serializers' with the name 'BasicSerializerTest' in the file '/test/decorators/basic_serializer_test.rb'.


Module option is also supported.


## Summary
** Saves a bit of typing
