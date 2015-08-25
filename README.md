# Hetchy

A high performance, thread-safe reservoir sampler with snapshot and percentile support.

Each reservoir can accepts an arbitrary number of samples but will consume a limited amount of memory based on the reservoir's size.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hetchy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hetchy

## Usage


Create a reservoir and designate how big you want it to be:

```ruby
reservoir = Hetchy.new(size: 1000)
```

Add samples as they arrive or are generated:

```ruby
reservoir << 123
```

You can add sets of samples as well:

```ruby
reservoir << [45,89,124,96]
```

You can calculate a percentile at any time:

```ruby
reservoir.percentile(95)
```

Hetchy supports high resolution percentiles as well:

```ruby
reservoir.percentile(99.99)
```

NOTE: you may need to increase your reservoir size for very high resolution percentiles

For threaded applications where the reservoir is accepting samples rapidly you can increase performance by snapshotting before running calculations on the reservoir:

```ruby
dataset = reservoir.snapshot
perc_95 = dataset.percentile(95)
```

If you want to reset the reservoir just empty it:

```ruby
reservoir.empty
```

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project and submit a pull request from a feature or bugfix branch.
* Please include tests. This is important so we don't break your changes unintentionally in a future version.
* Please don't modify the gemspec, Rakefile, version, or changelog. If you do change these files, please isolate a separate commit so we can cherry-pick around it.

## Credits

Parts of Hetchy are inspired by Eric Lindvall's [metriks]() gem.

## Copyright

Copyright (c) 2015 Matt Sanders. See LICENSE for details.

