require 'rubygems'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'active_support/all'
require 'mongoid'
require 'uri'
require 'mongoid-rspec'


mongoid_config = YAML.load_file(File.join(File.dirname(__FILE__),"mongoid.yml"))['test']

Mongoid.configure do |config|
  if !mongoid_config['uri'].blank?
    config.master = Mongo::Connection.from_uri(mongoid_config['uri']).db(mongoid_config['uri'].split('/').last)
  else
    config.master = Mongo::Connection.new(mongoid_config['host'], mongoid_config['port']).db(mongoid_config['database'])
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Mongoid::Matchers

  config.after :suite do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end

require 'clerk'
