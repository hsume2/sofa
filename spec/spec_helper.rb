$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'sofa'
#require 'spec'
#require 'spec/autorun'

require 'fakeweb'

FakeWeb.allow_net_connect = false

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
