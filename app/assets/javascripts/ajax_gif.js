$(document).ajaxStart(function() {
    $('.load_ajax').show();
});
$(document).ajaxStop(function() {
    $('.load_ajax').hide();
});