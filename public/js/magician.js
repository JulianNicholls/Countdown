/*
 * Javascript for Online Countdown
 */

$(function() {
    $("form").submit(function(e) {
        $(".words").prepend('<p class="wait">Searching...</p>');

        $("div.holder").fadeOut(300);
        $(".words").load('/words/' + $("#letters").val() + ' .word-holder');

        return false;
    });
});
