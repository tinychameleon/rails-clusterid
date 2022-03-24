# Rails ClusterId
A Ruby on Rails plugin for using [ClusterId](https://github.com/tinychameleon/clusterid) values as primary keys.

[![Gem Version](https://badge.fury.io/rb/rails-clusterid.svg)](https://badge.fury.io/rb/rails-clusterid)

## What's in the box?
✅ Simple usage documentation written to get started fast. [Check it out!](#usage)

⚡ A pretty fast implementation of Crockford32 in pure ruby. [Check it out!](#benchmarks)

📚 YARD generated API documentation for the library. [Check it out!](https://tinychameleon.github.io/rails-clusterid/)

🤖 RBS types for your type checking wants. [Check it out!](./sig/rails-clusterid.rbs)

💎 Tests against many Ruby versions. [Check it out!](#ruby-versions)

🔒 MFA protection on all gem owners. [Check it out!](https://rubygems.org/gems/rails-clusterid)


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails-clusterid'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails-clusterid

### Compatibility
#### Ruby Versions
This gem is tested against the following Ruby versions:

- 2.7.5
- 3.0.3
- 3.1.1

#### Rails Versions
This gem is tested against the following Ruby on Rails versions:

- 7.0.x

## Usage
To use `ClusterId` values for all model primary keys automatically create a new initializer for your application.

```ruby
# config/initializers/clusterid.rb

Rails.application.config.clusterid do |c|
  c.add_generator(:default, ClusterId::V1::Generator.new)
end

Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :clusterid
end
```

The above configures the `rails-clusterid` plugin to use version 1 `ClusterId` values by default and configures ActiveRecord to use ClusterId values for primary keys.
You must add a `:default` generator, and the generator itself is configurable.
See the [ClusterId repository for information on how to configure a generator](https://github.com/tinychameleon/clusterid).

Once the initializers are complete, include the `ClusterId::Rails::Model` concern into your `ApplicationRecord`.

```ruby
# app/models/application_record.rb

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include ClusterId::Rails::Model
end
```

Migrations are supported and will automatically use ClusterId values as primary keys and foreign keys.
This includes join tables.

### Manual Usage 
If you would like to selectively use `ClusterId` values across your models and migrations, just manually select the `:clusterid` type.

```
$ rails g model person name:string --primary-key-type=clusterid
```

You can use it within migration files as well.

```ruby
create_table :people, id: :clusterid do |t|
  t.string :name
end
```

Since the type works with ActiveRecord you can also specify it as a foreign key.

```ruby
create_table :hobbies, id: :clusterid do |t|
  t.string :name

  t.references :person, null: false, foreign_key: true, type: :clusterid
end
```

### ClusterId Ordering
The ClusterId values are k-sortable and will be ordered by creation time before any other part of the ID.
If you would like to read values from the ClusterId binary data stored within the database, you can deconstruct the raw data using a function.

For example, to extract the timestamp data while using PostgreSQL:
```sql
to_timestamp(('x' || encode(substring(id for 8), 'hex'))::bit(64)::bigint / 1000.0)
```

See the [ClusterId repository for documentation about the binary representation](https://github.com/tinychameleon/clusterid).

### More Information
For more detailed information about the library [see the API documentation](https://tinychameleon.github.io/rails-clusterid/).


## Contributing

### Development
This plugin relies heavily on Docker for development; ensure it is running to use most development commands.

To get started development on this gem run the `bin/setup` command. This will build the testing Docker image and run the tests and linting commands to ensure everything is working properly.

### Testing
Use the `bundle exec rake test` command to run unit tests. To install the gem onto your local machine for general integration testing use `bundle exec rake install`.

To test the gem against each supported version of Ruby and databases use `bin/test_versions`. This will create a Docker image for each version and run the tests and linting steps.

### Releasing
Do the following to release a new version of this gem:

- Update the version number in [lib/rails-clusterid/version.rb](./lib/rails-clusterid/version.rb)
- Ensure necessary documentation changes are complete
- Ensure changes are in the [CHANGELOG.md](./CHANGELOG.md)
- Create the new release using `bundle exec rake release`

After this is done the following side-effects should be visible:

- A new git tag for the version number should exist
- Commits for the new version should be pushed to GitHub
- The new gem should be available on [rubygems.org](https://rubygems.org).

Finally, update the documentation hosted on GitHub Pages:

- Check-out the `gh-pages` branch
- Merge `main` into the `gh-pages` branch
- Generate the documentation with `bundle exec rake yard`
- Commit the documentation on the `gh-pages` branch
- Push the new documentation so GitHub Pages can deploy it
