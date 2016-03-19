=======
# Dynaset

``Dynaset`` is a way to provide developer an easy dumb doing changes in
their runtime settings and provide a way to do runtime handling without need
to redeployment and still keep I/O overhead smaller as possible (the only overhead
are there will be dedicated thread that will maintain the business logic of watching
over namespace). The logic of `settings` resolver are being based on `updated_at` value
on each backend journal.

Every operations inside of this gems remains to be safe and always want to be
safe as safe as possible without impacting some performance.

This gems will trying to support between different backend, including :

### Remote:
- Redis
- Consul

### Local:
- Dotenv
- Path

# Status

The core implementation are still on going. Please comeback after an awhile :+1:.

## TODO

- Move several resolver logics into manager (branch: develop)
- Implement the basic functionality using redis (branch: develop)
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
