# Ignore::Skylight::Rack::Endpoint

Rack middleware to set custom [skylight.io](http://skylight.io) endpoints for specific paths.
I'm using it to ignore Rack based health check responses in skylight.
It is based on teodor-pripoae's [suggestion](https://github.com/skylightio/skylight-ruby/issues/19).

WARNING: Uses skylights private API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-path-dependent-skylight-endpoint'
```

And then execute:

    $ bundle

## Customization

```ruby
use Rack::PathDependentSkylightEndpoint, path: '/healthcheck', endpoint: 'healthcheck'
```

Add this to your skylight config:

```
ignored_endpoints:
  - healthcheck
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

1. Fork it ( https://github.com/elitau/rack-path-dependent-skylight-endpoint/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
