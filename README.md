# fewer

Rack middleware to bundle assets and help you make fewer HTTP requests.

## How to use as a Rack app (config.ru example)

    app = Rack::Builder.new do
      map '/stylesheets' do
        run Fewer::App, 
          :root => File.dirname(__FILE__)+'/less_css', 
          :engine => Fewer::Engines::Less
      end
      
      map '/' do
        run MyApp
      end
    end
    
    run app

## How to use in Rails 3 router

    match '/stylesheets', :to => Fewer::App.new(
      :root => File.dirname(__FILE__)+'/less_css', 
      :engine => Fewer::Engines::Less
    )
        
## How to use in Rails as middleware

    config.middleware.insert 0, Fewer::MiddleWare, {
      :engine => Fewer::Engines::Css,
      :mount => '/stylesheets',
      :root => Rails.root.join('public', 'stylesheets')
    }

## Copyright

Copyright (c) 2010 Ben Pickles. See LICENSE for details.
