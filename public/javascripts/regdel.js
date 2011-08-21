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

// load css programatically
function svx_loadcss(csshref) {
  $('<link>', {
    'rel':  'stylesheet',
    'type': 'text/css',
    'href': csshref
  }).appendTo('head');
}

$('document').ready(function() {


  $(":input:not(:button,:submit,:checkbox)").addClass("text");
  $(":button,:submit").addClass("button");

});



// Courtesy of Joey
// Public Domain Code
// http://joey.kitenet.net/blog/entry/relative_dates_in_html/


var timeUnits = new Array;
timeUnits['minute'] = 60;
timeUnits['hour'] = timeUnits['minute'] * 60;
timeUnits['day'] = timeUnits['hour'] * 24;
timeUnits['month'] = timeUnits['day'] * 30;
timeUnits['year'] = timeUnits['day'] * 364;
var timeUnitOrder = ['year', 'month', 'day', 'hour', 'minute'];


function relativeDate(date) {
    var now = new Date();
    var offset = date.getTime() - now.getTime();
    var seconds = Math.round(Math.abs(offset) / 1000);

    var ret = "";
    var shown = 0;
    for (i = 0; i < timeUnitOrder.length; i++) {
        var unit = timeUnitOrder[i];
        if (seconds >= timeUnits[unit]) {
            var num = Math.floor(seconds / timeUnits[unit]);
            seconds -= num * timeUnits[unit];
            if (ret)
                ret += "and ";
            ret += num + " " + unit + (num > 1 ? "s" : "") + " ";

            if (++shown == 2)
                break;
        }
        else if (shown)
            break;
    }

    if (! ret)
        ret = "less than a minute "

    return ret + (offset < 0 ? "ago" : "from now");
}

$('document').ready(function() {
$('.calendar_select').datepick({dateFormat: 'yyyy-mm-dd'});
});
