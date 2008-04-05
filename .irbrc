# load libraries
require 'rubygems'
require 'wirble' # gem install wirble
require 'pp'

# start wirble (with color)
Wirble.init
Wirble.colorize

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
end
