/*
 * Javascript for Online Countdown
 */

$(function() {

    $("form").submit( function() {
        $("div.holder").slideUp( 400 );
        $(".container").append( '<p class="wait">Searching...</p>' );

        $.getJSON( '/words/' + $("#letters").val(), field_words );

        return false;
    });
});


function field_words( data ) {
    var words  = data.words,
        nWords = words.length;

    var time  = '<div class="holder"><div class="header">' + nWords +
        ' words in ' + data.time + ' seconds</div></div>';

    $("p.wait").remove();
    $(".container").append( time );

    var len     = 10,
        wstring = '';

    for( i = 0; i < nWords; ++i ) {
        var w = words[i].toUpperCase();

        if( w.length != len ) {
            if( wstring.length )
                insert_div( wstring, len );

            len     = w.length;
            wstring = dict_link( w );
        }
        else
            wstring += ', ' + dict_link( w );
    }

    insert_div( wstring, len );
}


function insert_div( wstring, len ) {
    var len = worddiv = '<div class="holder"><div class="header" id="header-' + len + '">' + len +
        '-letter words</div><p>' + wstring + '</p></div>';

    $(".container").append( worddiv );
}


function dict_link( w ) {
    return '<a href="http://dictionary.reference.com/browse/' + w +
        '" target="_blank">'+ w + '</a>';
}

