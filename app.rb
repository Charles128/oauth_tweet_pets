require 'sinatra'
require 'sinatra/activerecord'
require 'omniauth'
require 'omniauth-twitter'
require 'twitter'

enable :sessions

use OmniAuth::Builder do
  provider :twitter, 'EGv15OVLCPFSMeX8MQKQg', 'LHr0nK2kdtGfGgrlIz7Hc5mfAHssmgLrh5kuO0UHM'
end

  Twitter.configure do |config|
    config.consumer_key = 'EGv15OVLCPFSMeX8MQKQg'
    config.consumer_secret = 'LHr0nK2kdtGfGgrlIz7Hc5mfAHssmgLrh5kuO0UHM'
  end


get '/' do
  '<a href="/auth/twitter">Post to Twitter by signing in to Twitter</a>'
end


get '/auth/:twitter/callback' do
  
  auth = request.env['omniauth.auth']
  session[:token]  = auth[:credentials][:token]
  session[:secret] = auth[:credentials][:secret]

 
  redirect '/tweets'
end


get '/tweets' do
  erb :tweets

end

post '/tweets' do
  user = Twitter::Client.new(
    :oauth_token        => session[:token],
    :oauth_token_secret => session[:secret]
  )

  user.update(params[:text])
end  
