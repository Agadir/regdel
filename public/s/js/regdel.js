/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.
function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }

    return vars;
}

$('document').ready(function() {

    var hash = getUrlVars();
    if (hash['error']) {
        var err = '<div id="error">' + unescape(hash['error']) + '</div>';
        $("body").append(err);
    }


    /* To be used with forms */
    $.getScript("/s/js/jquery/plugins/jquery.url.js", function() {
        if(jQuery.url.segment(0)=='account' && jQuery.url.segment(1)=='edit') {
            var myid = jQuery.url.segment(2);
            $.getJSON("http://dev-48-gl.savonix.com:3000/json/account/"+myid, function(data) {
                $.each(data, function(i, item) {
                    if ($('#' + i).length) {
                        $('#' + i).val(item);
                    }
                });
            });
            $("form").append('<input type="hidden" name="id" value="' + myid +'" />');
        }
    });
});