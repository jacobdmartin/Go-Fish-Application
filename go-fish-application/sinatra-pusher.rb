require 'bundler'
Bundler.require

class Server < Sinatra::Base
  configure do
    register Sinatra::Reloader
    Pusher.app_id = ''
    Pusher.key = ''
    Pusher.secret = ''
  end

  get '/' do
    slim :log_in
  end

  post '/messages' do
    Pusher['test_channel'].trigger('new_message', :message => params['message'])
  end
end