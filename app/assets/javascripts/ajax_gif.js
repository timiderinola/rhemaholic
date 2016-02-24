$(document).ajaxStart(function() {
    $('.load_ajax').show();
});
$(document).ajaxStop(function() {
    $('.load_ajax').hide();
});
$(document).ajaxError(function() {
    $('#ajax-error').show();
});