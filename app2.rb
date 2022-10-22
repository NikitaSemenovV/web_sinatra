require 'sinatra/contrib'
require 'sinatra/base'
module MyAppModule
  class App < Sinatra::Base
    register Sinatra::Namespace
    namespace '/api/v1' do
      get '/*' do
        "I don't know what is the #{params[:splat]}. It's what you typed."
      end
    end
  end
end
