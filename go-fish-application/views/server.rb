require 'sinatra'
require 'sinatra/reloader'
require 'sprockets'
require 'sass'
require_relative 'lib/game'
require_relative 'lib/player'

class Server < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
  end
  enable :sessions
  set :environment, Sprockets::Environment.new
  environment.append_path "assets/stylesheets"
  environment.append_path "assets/javascripts"
  environment.css_compressor = :scss
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end
  
  def self.game do
    @@game || Game.new
  end 

  get '/' do
    slim :index
  end

  post '/join' do
    player = player.new(params['name'])
    session[:current_player] = player
    self.class.game.add_player(player)
    redirect '/game'
  end

  get '/game' do
    redirect '/' if self.class.game.empty?
    slim :game, locals: {game = self.class.game, current_player = sessions[:current_player]}
  end
end