# Mongoid::Clerk

[![Build Status](https://secure.travis-ci.org/80beans/mongoid-clerk.png?branch=master)](http://travis-ci.org/80beans/mongoid-clerk)

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/80beans/mongoid-clerk)

A simple logger for Mongoid.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-clerk', :require => 'clerk'

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
2. Fix it
3. Push it
4. Pullreq it
