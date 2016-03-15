=======
# Dynaset

``Dynaset`` is a way to provide developer an easy dumb doing changes in
their runtime settings and provide a way to do runtime handling without need
to redeployment and still keep I/O overhead smaller as possible (the only overhead
are there will be dedicated thread that will maintain the business logic of watching
over namespace).

Every operations inside of this gems remains to be safe and always want to be
safe as safe as possible without impacting some performance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dynaset'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynaset

## Usage

This gem will provide a way to have a runtime settings with less
overhead in I/O.

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## TODO

- Provide an easily reusable view that can be used view in Rails or rack equivalent views
  to control behavior of the variables.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aerosign/dynaset.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).
