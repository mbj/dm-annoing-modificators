$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'dm-annoing-modificators'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations'

DataMapper.setup(:default,
  :adapter => 'sqlite',
  :database => ':memory:'
)

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

class Book
  include DataMapper::Resource
  property :id,Serial
  property :name, String, :required => true
end

DataMapper.auto_migrate!

RSpec.configure do |config|
  
end
