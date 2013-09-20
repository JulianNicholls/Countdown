/*
 * Javascript for Online Countdown
 */
 
$(function() {

    $("form").submit( function() {
        var $ltr    = $("#letters"),
            letters = $ltr.val();
        
        $ltr.val( letters.toUpperCase() );
        
        $("div.holder").slideUp( 400 );
        
        $.getJSON( '/words/' + letters, function( data ) {
            var words = data.words;
            var time  = '<div class="holder"><div class="header">' + 
                  words.length + ' words in ' + data.time + 
                  ' seconds</div></div>';

            $(".container").append( time );

            var len     = 10;
            var wstring = '';
            
            for( i = 0; i < words.length; ++i ) {
                var w = words[i].toUpperCase();
                
                if( w.length != len ) {
                    if( wstring.length )
                        insert_div( wstring, len );

                    len     = w.length;
                    wstring = w;
                }
                else
                    wstring += ', ' + w;
            }

            insert_div( wstring, len );
        });
        
        return false;
    });
});

function insert_div( wstring, len ) {
    var len = worddiv = '<div class="holder"><div class="header">' + len +
          '-letter words</div><p>' + wstring + '</p></div>';
          
    $(".container").append( worddiv );
}