require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

get '/' do
  session[:money] = 100 unless session[:money]
  redirect '/broke' unless session[:money] > 0
  erb :bet
end

post '/' do
  number = rand(1..3)
  guess = params[:guess].to_i
  bet_amount = params[:bet].to_i

  if (bet_amount < 1) || (bet_amount > session[:money])
    session[:message] = "Bets must be between $1 and $#{session[:money]}."
    redirect '/'
  end

  if guess == number
    session[:money] += bet_amount
    session[:message] = 'You have guessed correctly.'
  else
    session[:money] -= bet_amount
    redirect '/broke' unless session[:money] > 0
    session[:message] = "You guessed #{guess} but the number was #{number}."
  end

  erb :bet
end

get '/broke' do
  erb :broke
end

post '/reset' do
  session[:money] = 100
  session[:message] = 'You have reset the game.'
  redirect '/'
end
