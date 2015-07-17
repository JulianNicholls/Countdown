/*
 * Javascript for Online Countdown
 */

$(function() {
    $("form").submit( function() {
        $(".words").prepend( '<p class="wait">Searching...</p>' );

        $("div.holder").fadeOut( 300, function() {
            $(".words").load( '/words/' + $("#letters").val() + ' .word-holder' );
        });

        return false;
    });
});
