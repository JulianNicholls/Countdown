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

__END__

@@style
$bkgr: #071F39;
$text: white;
$fsize: 14pt;
$bigsize: 28pt;
$hheight: 40px;
$hsize: 18pt;

body {
    background: $bkgr;
    color: $text;
    padding-top: 70px
}

nav img {
    margin-top: -7px;
}

img.center {
    display: block;
    margin: 20px auto;
}

form {
    height: 300px;
    background: url(/images/countdown.jpg) no-repeat;
    padding: 245px 0 0 40px;
}


label {
    width: 100px;
}

input {
    margin-right: 20px;
}

#letters {
    text-transform: uppercase;
    background: rgba( 100%, 100%, 100%, 0.7);
}

div.holder {
    margin-top: 20px;
    clear: both;
    border: 1px solid lighten( $bkgr, 40% );
    overflow: hidden;

    &:first { margin-top: 40px; }

    p { margin: 10px; }

    a {
        text-decoration: none;
        color: $text;

        &:hover { color: #ffffa0; }
    }
}

div.header {
    background: lighten( $bkgr, 10% );
    height: $hheight;
    line-height: $hheight;
    font-size: $hsize;
    text-align: center;

    span {
        color: #ffffa0;
    }
}

div#header-9 { background: #800; }  // Red header for 9 letter words

footer {
    margin-top: 20px;
    padding: 10px 0 0 10px;
    border-top: 2px solid #aaa;
    background-color: #ddd;
    color: black;

    nav ul {
        list-style-type: none;

        li {
            float: left;
            margin-right: 20px;
        }
    }

    small {
        font-size: 80%
    }
}

