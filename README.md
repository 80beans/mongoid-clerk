# Mongoid::Clerk

A simple logger for Mongoid.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-clerk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-clerk

## Usage

Include `Clerk::Logger` in your model, then log anything with `log()`. The first argument is the message and the second the level.

You can add default fields to your log entry by adding `clerk_always_include` this method accepts an array of fields it should include, or a hash if you want to rename a field.

Clerk adds a polymorphic relation to the model `log_items` so you can scope log entries on this model.

`Clerk::Log` behaves like a regular mongoid model for easy access to your log entries.

example model:

    class User
      include Clerk::Logger

      field :name
      field :address

      clerk_always_include :name, :address => :place

      def something
        log('Something went wrong!', :error)
      end

    end



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
