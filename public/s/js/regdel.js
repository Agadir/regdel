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
    if(jQuery.url.segment(0)=='account' && jQuery.url.segment(1)=='edit') {
        $('#type_id').jselect({
            replaceAll: true,
            loadType: "GET",
            loadUrl: "/s/xml/raw/account_types_select.xml",
        });
        var myid = jQuery.url.segment(2);
        $.getJSON("/json/account/"+myid, function(data) {
            $.each(data, function(i, item) {
                if ($('#' + i).length) {
                    if($('#' + i).attr("type")=="checkbox") {
                        $('#' + i).val([item]);
                    } else {
                        $('#' + i).val(item);
                    }
                }
            });
        });
        $("form").append('<input type="hidden" name="id" value="' + myid +'" />');
    }
    if(jQuery.url.segment(0)=='entry' && (jQuery.url.segment(1)=='new' || jQuery.url.segment(1)=='edit')) {
        $('.account_id:first').jselect({
            replaceAll: true,
            loadType: "GET",
            loadUrl: "/raw/account/select",
            onComplete: function() {
                $('.account_id:first option').clone().appendTo('.account_id:not(:first)');
            }
        });
        if(jQuery.url.segment(1)=='edit') {
          var myid = jQuery.url.segment(2);
          update_journal_entry_form(myid);
        }
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
        $(".entry_row").toggle(
            function () {
                $(".entry_detail").remove();
                var myid = $(this).get(0).getAttribute('id');
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
    $(".credit-row:not(:first)").remove();
    var i = 0;
    $.each(data.credits, function(i, item) {
        if(i>=1) {
          $(".credit-row:first").clone().appendTo("#entry_form_table tbody");
        }
        $(".credit-row:eq("+i+") input").val(item.amount);
        i++;
    });

    $(".debit-row:not(:first)").remove();
    var i = 0;
    $.each(data.debits, function(i, item) {
        if(i>=1) {
        $(".debit-row:first").clone().appendTo("#entry_form_table tbody");
        }
        $(".debit-row:eq("+i+") input").val(item.amount);
        i++;
    });
    $('input').click(function() {
        update_journal_entry_form(myid);
    });
  });
}