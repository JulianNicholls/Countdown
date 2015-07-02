/*
 * Javascript for Online Countdown
 */

$(function() {
    $("form").submit( function() {
        $(".words").prepend( '<p class="wait">Searching...</p>' );

        $("div.holder").slideUp( 400 );

        $(".words").load( '/words/' + $("#letters").val() + ' .word-holder' );

        return false;
    });
});
