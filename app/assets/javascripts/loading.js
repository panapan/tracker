$(document).ready(function(){
    // $('#loading-indicator').hide()  // hide it initially.

    $(document).ajaxSend(function(event, request, settings) {
        $('#loading-indicator').css('display','block');
        $('#loading-indicator').show();
    });

    $(document).ajaxComplete(function(event, request, settings) {
        $('#loading-indicator').hide();
    });
});