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
  $(":input:not(:submit)").addClass("text");

  if(jQuery.url.segment(0)=='ledger' || jQuery.url.segment(0)=='ledgers' ) {
    $("#nav-ledger","#navigation").addClass("active");
  }

});
