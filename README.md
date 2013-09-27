# Guard::JasmineRails

Guard Plugin for running Jasmine Javascript tests via the [JasmineRails gem](https://github.com/searls/jasmine-rails)

## Installation

```
# Gemfile
gem 'jasmine-rails'
gem 'guard-jasmine-rails'
```

## Usage

```
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
```
# example to configure plugin
guard 'jasmine-rails', all_on_start: false do
end
```

#### `all_on_start` (default true)
toggle running all Jasmine tests when Guard is first started.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
