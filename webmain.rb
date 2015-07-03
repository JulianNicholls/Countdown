require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'json'

require './countdownwordlist'

# Countdown for the Web via Sinatra
class CountdownApp < Sinatra::Application
  puts 'Loading word list...'
  @list = CountdownWordList.new

  class << self
    attr_reader :list
  end

  def list
    self.class.list
  end

  get('/css/style.css') { scss :style }

  get '/' do    # Show the form
    slim :index
  end

  get '/words/:letters' do    # Return the words as formatted HTML
    @words  = list.words_from(params[:letters])

    slim :words
  end
end
