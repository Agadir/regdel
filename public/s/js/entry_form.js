$('document').ready(function() {

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
        $(".credit-row:eq("+i+") select").val(item.account_id);
        i++;
    });

    $(".debit-row:not(:first)").remove();
    var i = 0;
    $.each(data.debits, function(i, item) {
        if(i>=1) {
        $(".debit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        }
        $(".debit-row:eq("+i+") input").val(item.amount);
        $(".debit-row:eq("+i+") select").val(item.account_id);
        i++;
    });
    $('input').unbind("click");
    $('input').one("click",function() {
        update_journal_entry_form(myid);
    });
  });
}
