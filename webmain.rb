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
  
  get( '/css/style.css' ) { scss :style }

  get '/' do    # Show the form
    slim :index
  end

  get '/words/:letters' do    # Return the words as formatted HTML
    start   = Time.now
    @words  = list.words_from( params[:letters] )
    finish  = Time.now

    @time  = format( '%.3f', finish - start )
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
  font: 14pt/21pt arial, helvetica, sans-serif;
}

img.center {
  display: block;
  margin: 20px auto;
}

.container { width: 960px; margin: 0 auto }

form {
  height: 100px;
  background: url(/images/countdown.jpg) no-repeat;
  display: block;
  width: 940px;
  overflow: hidden;
  margin: 20px auto;
  padding: 245px 0 0 40px;
}

label {
  width: 140px;
  float: left;
  font-size: $bigsize;
  margin-top: 12px;
}

input {
  font-size: $bigsize;
  float: left;
  margin-right: 20px;
}

#letters {
  text-transform: uppercase;
  background: rgba( 100%, 100%, 100%, 0.7);
}

div.holder {
  margin-top: 20px;
  clear: both;
  border: 1px solid lighten( $bkgr, 30% );
  overflow: hidden;

  p { margin: 10px; }

  a       { text-decoration: none; color: $text; }
  a:hover { color: #ffffa0; }
}


div.holder:first { margin-top: 40px; }

div.header {
  background: lighten( $bkgr, 10% );
  height: $hheight;
  line-height: $hheight;
  font-size: $hsize;
  text-align: center;
}

div#header-9 { background: #800; }  /* Red header for 9 letter words */
