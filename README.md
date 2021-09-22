# Velocity Client

Interact with Velocity Teams API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'velocity_client_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install velocity_client_ruby

## Configuration

In order to be able to Access Velocity API you need to have a token.
You can set it up all your environemnt variables using configure method:

```ruby
  Velocity.configure do |config|
    config.api_token = "abc"
  end
```

## Usage

```ruby
require "velocity"

contributors_list = CSV.parse(File.read('./examples/contributors-list.csv'), headers: true)

contributors_list.map do |contributor|
  velocity_contributor = Velocity::Contributor.find_by(name: contributor['name'])

  if velocity_contributor
     puts "Contributor #{velocity_contributor.id} found.\n#{velocity_contributor.inspect}"
  else
    role = Velocity::Role.find_by(name: contributor['role_name'])
    raise 'Role not found' if role.nil?

    invite = Velocity::Invite.create(
      name: contributor['name'],
      email: contributor['email'],
      job_function: contributor['job_function'],
      role_ids: [role.id]
    )

    puts "Invite #{invite.id} sent.\n#{invite.inspect}"
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Publishing

1. Open version.rb file and version_spec.rb file and bump version
2. run:

```
rake release
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codeclimate/velocity-client-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the velocity-client-ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/velocity_client_ruby/blob/master/CODE_OF_CONDUCT.md).
