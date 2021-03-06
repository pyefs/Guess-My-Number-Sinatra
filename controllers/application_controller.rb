class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  # set public folder for static files
  set :public_folder, File.expand_path('../../public', __FILE__)

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  enable :sessions

  get '/' do
    erb :index
  end

  get '/level' do
  	erb :level
  end

  get '/game' do
  	session['chance'] = 1
  	session['guess_list'] = []
  	erb :game
  end

  post '/game' do
  	session['guess'] = params['guess']
  	attempt
  	addtolist(session['guess'])
  	if session['chance'] > session['limit']
  		erb :game_over
  	elsif session['guess'].to_i == session['number']
  		erb :win
  	elsif session['guess'].to_i != session['number']
  		erb :game
  	end
  end

  get '/lvl' do
  	session['limit'] = params[:chance].to_i
  	session['level'] = params[:set]
  	if session['level'] == "EASY"
  		session['number'] = rand(1..20)
  	elsif session['level'] == "MEDIUM"
  		session['number'] = rand(1..50)
  	else
  		session['number'] = rand(1..100)
  	end
  	redirect to('/game')
  end


  def attempt 
  	session['chance'] += 1
  end
  
  def addtolist(guess)
  	session['guess_list'] << guess
  end
end
