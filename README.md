# DeferProc

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/defer_proc`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'defer_proc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install defer_proc

## Usage

This gem can be used to defer execution of some blocks until certain conditions are met.

The `DeferProc` class takes a block on initialization to run at a later time. The `DeferProc#until` and `DeferProc#while` methods are used to specify the conditions for later execution:

```ruby
  2.2.1 :001 > require 'defer_proc'
   => true
  2.2.1 :002 > trigger = false
   => false
  2.2.1 :003 > DeferProc.new { puts "Hello, World!" }.until { trigger }
   => #<Thread:0xa3c8e58@/path/to/lib/defer_proc.rb:16 run>
  2.2.1 :004 > trigger = true
   => true
  Hello, World
```

The method `DeferProc#until` defers execution *until* the block provided is true, and the method `DeferProc#while` defers execution *while* the block provided is true. The block provided to `DeferProc#until` or `DeferProc#while` runs in a separate thread, which polls the value of the conditional at specified intervals. By default, polling occurs every 1/10 of a second, although the interval can be specified when `DeferProc` is initialized:

```ruby
require 'defer_proc'

# Defer usage of class until it exists, polling every second
DeferProc.new(1.0) { FutureClass.do_something }.until { defined?(FutureClass) }

class FutureClass
  # Class definition
end

# FutureClass.do_something gets called
```

This gem was written for use in the [`dotfile`](https://github.com/tedstudley/dotfile.git) gem, to enable certain Rails features to be wrapped from inside the .irbrc or .pryrc ruby dotfiles.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/TedStudley/defer_proc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
