# Guard::JasmineRails

Guard Plugin for running Jasmine Javascript tests via the [JasmineRails gem](https://github.com/searls/jasmine-rails)

## Installation

Install gem via rubygems:
```bash
$ gem install guard-jasmine-rails
```

Setup your Guardfile with the proper configuration with:
```bash
$ guard init jasmine-rails
```

## Usage

```ruby
# Guardfile
guard 'jasmine-rails' do
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) do |m|
    "spec/javascripts/#{ m[1] }_spec.#{ m[2] }"
  end
end
```

### Options

configure the plugin by passing options into the guard initializer. ex:

```ruby
# example to configure plugin
guard 'jasmine-rails', all_on_start: false do
end
```

#### `all_on_start` (default true)
toggle running all Jasmine tests when Guard is first started.


## Contributing

Patches are always welcome and thank you to all [project contributors](https://github.com/thegarage/guard-jasmine-rails/graphs/contributors)!

Interested in contributing?  Review the project [contribution guidelines](CONTRIBUTING.md) and get started!
