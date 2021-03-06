require 'test/unit'

require 'rubygems'
require 'mocha'
require 'rack/test'

begin
  require 'leftright'
rescue LoadError
  puts "You're missing out on pretty colours! `gem install leftright`"
end

require 'fewer'

module TestHelper
  
  private
  
  def decode(string)
    Fewer::Serializer.decode(string)
  end

  def encode(obj)
    Fewer::Serializer.encode(obj)
  end
  
end
