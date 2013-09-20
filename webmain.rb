require './countdownwordlist'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'json'


$list = CountdownWordList.new


get( '/css/style.css' ) { scss :style } 

get '/' do    # Show the form

  slim :index
end

get '/words/:letters' do    # Return the words via AJAJ (JSON format)
  start   = Time.now
  words   = $list.words_from( params[:letters] );
  finish  = Time.now
  
  content_type :json
  { :time  => sprintf( "%.3f", finish - start), 
    :words => words
  }.to_json
end


__END__

@@style
$bkgr: #000050;
$text: white;
$fsize: 14pt;
$bigsize: 24pt;
$hheight: 40px;

body {
  background: $bkgr;
  color: $text;
  font: $fsize arial, helvetica, sans-serif;
}

img.center {
  display: block;
  margin: 20px auto;
}

.container { width: 960px; margin: 0 auto }

form { 
  overflow: hidden;
  margin-bottom: 20px;
}

label {
  display: inline-block;
  width: 140px;
  float: left;
  font-size: $bigsize;
}

input {
  font-size: $bigsize;
  float: left;
  margin-right: 20px;
}

div.holder {
  margin-top: 20px;
  clear: both;
  border: 1px solid lighten( $bkgr, 30% );
  overflow: hidden;
  
  p { padding: 10px; }
}


div.holder:first_of_type { margin-top: 40px; }

div.header {
  background: lighten( $bkgr, 10% );
  height: $hheight;
  line-height: $hheight;
  font-size: $bigsize;
  text-align: center;
}
