# Hetchy

[![Gem Version](https://badge.fury.io/rb/hetchy.svg)](http://badge.fury.io/rb/hetchy) [![Code Climate](https://codeclimate.com/github/nextmat/hetchy.png)](https://codeclimate.com/github/nextmat/hetchy)

A high performance, thread-safe reservoir sampler for ruby with snapshot and percentile support.

## Benefits/Goals

* Generate statistics for large datasets with a very small in-memory footprint
* Generate percentiles/quantiles for a known set or numbers or for real-time streaming set
* Ability to capture sample state at a moment in time for further analysis
* Speed
* Thorough test suite
* No dependencies

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hetchy'
```

And then `$ bundle`

Or install it yourself with:

    $ gem install hetchy

## Usage


Create a reservoir and designate how big you want it to be:

```ruby
reservoir = Hetchy::Reservoir.new(size: 1000)
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

NOTE: you may need to increase reservoir size for _very_ high resolution percentiles. Experiment to see what works for your data set.

For threaded applications where the reservoir is accepting samples rapidly you can increase performance by snapshotting before running a series of calculations on the reservoir:

```ruby
dataset  = reservoir.snapshot

perc_95  = dataset.percentile(95)
perc_99  = dataset.percentile(99)
perc_999 = dataset.percentile(99.9)
```

Clear the reservoir to reset it:

```ruby
reservoir.clear
```

## Datasets

If you have an existing series you can use Dataset to generate stats for it:

```ruby
my_series = Array(1..1000)
dataset = Hetchy::Dataset.new(my_series)

perc_95 = dataset.percentile(95)   #=> 950.95
median  = dataset.median           #=> 500.5
```

## Stats Details

For those interested:

* Reservoir sampling is based on Vitter's algorithm R, ensures a uniform sampling probability for every entry in the series
* Percentile calculations use weighted averages, not nearest neighbor

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

