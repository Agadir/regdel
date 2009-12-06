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



    if(jQuery.url.segment(0)=='accounts') {
        $("tbody.accounts tr").append('<td>Close</td>');
        $("tbody.accounts tr td:last").click(function () {
            var myid = $(this).parent().get(0).getAttribute('id');
            $.ajax({
                type: "POST",
                url: "/account/close",
                data: ({id : myid}),
                success: function(msg){
                    $('#'+myid).remove();
                }
                });
        });
    }

    if(jQuery.url.segment(0)=='journal') {
        $(".entry_row").each(
          function () {
            var myid = $(this).get(0).getAttribute('id');
            $(this).append('<td class="notoggle"><a href="/entry/edit/'+myid+'">edit</a></td>');
          }
        );
        $(".entry_row td:not(.notoggle)").toggle(
            function () {
                $(".entry_detail").remove();
                var myid = $(this).parent().get(0).getAttribute('id');
                $.getJSON("/json/entry/"+myid, function(data) {
                    $.each(data.credits, function(i, item) {
                        var myamounts = '<tr class="entry_detail credit">';
                        myamounts += '<td>'+item.account_id+'</td>';
                        myamounts += '<td>'+item.memorandum+'</td>';
                        myamounts += '<td/>';
                        myamounts += '<td>'+item.amount+'</td>';
                        myamounts += '</tr>';
                        $("#"+myid).after(myamounts);
                    });
                    $.each(data.debits, function(i, item) {
                        var myamounts = '<tr class="entry_detail debit">';
                        myamounts += '<td>'+item.account_id+'</td>';
                        myamounts += '<td>'+item.memorandum+'</td>';
                        myamounts += '<td>'+item.amount+'</td>';
                        myamounts += '<td/>';
                        myamounts += '</tr>';
                        $("#"+myid).after(myamounts);
                    });
                });
            },
            function () {
                $(".entry_detail").remove();
            }
        );
    }
});

function update_journal_entry_form(myid) {
  
  $.getJSON("/json/entry/"+myid, function(data) {
    $("#memorandum").val(data.memorandum);
    $("#entry_datetime").val(data.entered_on);
    $(".credit-row:not(:first)").remove();
    var i = 0;
    $.each(data.credits, function(i, item) {
        if(i>=1) {
          $(".credit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        }
        $(".credit-row:eq("+i+") input").val(item.amount);
        i++;
    });

    $(".debit-row:not(:first)").remove();
    var i = 0;
    $.each(data.debits, function(i, item) {
        if(i>=1) {
        $(".debit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        }
        $(".debit-row:eq("+i+") input").val(item.amount);
        i++;
    });
    $('input').click(function() {
        update_journal_entry_form(myid);
    });
  });
}