require 'test_helper'

class AppTest < Test::Unit::TestCase
  
  include TestHelper
  
  def setup
    @app = stub
    @engine = stub(
      :check_request_extension => true,
      :content_type => 'text/css',
      :read => 'content'
    )
    Fewer::Engines::Css.stubs(:new).returns(@engine)
   
    @app = Rack::Builder.new do
      map '/' do
        use Fewer::MiddleWare,
              :root => '/some/root/path', 
              :engine => Fewer::Engines::Css,
              :mount => '/css'
        run lambda{|env| [200, {'Content-Type'=>'text/html'},'Hello World']}
      end
    end
    
    @browser = Rack::Test::Session.new(Rack::MockSession.new(@app))
  end

  def test_middleware_intercepts_path
    @browser.get "/css/#{encode('file')}.css"
    assert_equal 'content', @browser.last_response.body
    assert_equal 'text/css', @browser.last_response.content_type
  end
  
  def test_middleware_delegates_to_app
    @browser.get "/blah/foobar.css"
    assert_equal 'Hello World', @browser.last_response.body
    assert_equal 'text/html', @browser.last_response.content_type
  end

  

end
