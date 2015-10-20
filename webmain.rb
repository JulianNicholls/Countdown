require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'json'

require './countdownwordlist'

# Countdown for the Web via Sinatra
class CountdownApp < Sinatra::Application
  puts 'Loading word list...'
  @list = CountdownWordList.new 'countdown.words'

  class << self
    attr_reader :list
  end

  def list
    self.class.list
  end

  get('/css/style.css') { scss :style }

  get('/') { slim :index }

  # Return the words as formatted HTML

  get '/words/:letters' do
    @words = list.words_from(params[:letters])

    erb :words, layout: !request.xhr?
  end
end
