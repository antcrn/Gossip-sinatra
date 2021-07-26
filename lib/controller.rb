require 'bundler'
Bundler.require

require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  get '/gossips/new' do
    erb :new_gossip, locals: {gossips: Gossip.all}
  end
  post '/gossips/new' do
    Gossip.new(params["id"].to_i,params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end
  get '/gossips/:id' do
      erb :show, locals:{id: params["id"].to_i, gossips: Gossip.find(params["id"].to_i)}
  end
  get '/gossips/:id/edit' do
  erb :edit,locals:{id: params["id"].to_i, gossips: Gossip.find(params["id"].to_i)}
  end
  post '/gossips/:id/edit' do
    Gossip.update(params["id"].to_i,params["gossip_author"],params["gossip_content"])
    redirect '/'
  end
  post '/gossips/:id/delete' do
    Gossip.delete(params["id"].to_i)
    redirect '/'
  end
end