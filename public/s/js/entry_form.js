$('document').ready(function() {
  $("#nav-entry").addClass("active");

  $('.account_id:first','form').jselect({
      replaceAll: true,
      loadType: "GET",
      loadUrl: app_prefix+"/raw/account/select",
      onComplete: function() {
          $('.account_id:first option','form').clone().appendTo('.account_id:not(:first)','form');
      }
  });


  if(jQuery.url.segment(1)=='new') {
    var amount_total = 0;
    $("#another_credit").live("click",function() {
        $("#another_debit").css("display","none");
        $(".credit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        $(".remove_credit:last").css("display","inline");
        $(".debit-row input").attr("readonly","readonly");
        $("#journal-entry-amounts","form").bind("click keyup keypress mouseenter mouseleave",function() {
            amount_total = $(".credit-row input").sum();
            $(".debit-row input").val(amount_total);
        });
    });

    $(".remove_credit").live("click",function() {
        $(this).parent().parent().remove();
        if($(".remove_credit").length == 1) {
          $("#another_debit").css("display","inline");
          $(".debit-row input").removeAttr("readonly");
        }
    });
  
    $("#another_debit").live("click",function() {
        $("#another_credit").css("display","none");
        $(".debit-row:first").clone().prependTo("#journal-entry-amounts tbody");
        $(".remove_debit:not(:first)").css("display","inline");
        $(".credit-row input").attr("readonly","readonly");
        $("#journal-entry-amounts","form").bind("click keyup keypress mouseenter mouseleave",function() {
            amount_total = $(".debit-row input").sum();
            $(".credit-row input").val(amount_total);
        });
    });

    $(".remove_debit").live("click",function() {
        $(this).parent().parent().remove();
        if($(".remove_debit").length == 1) {
          $("#another_credit").css("display","inline");
          $(".credit-row input").removeAttr("readonly");
        }
    });
  }

  if(jQuery.url.segment(1)=='edit') {
    $(".amount_controls").hide();
    var myid = jQuery.url.segment(2);
    update_journal_entry_form(myid);
  }

});


function update_journal_entry_form(myid) {
  $("#journal-entry-form").append('<input type="hidden" name="id" value="'+myid+'"/>');
  $.getJSON(app_prefix+"/json/entry/"+myid, function(data) {
    $("#memorandum").val(data.memorandum);
    $("#entry_datetime").val(data.entered_on);
    $(".credit-row:not(:first)").remove();
    var i = 0;
    $.each(data.credits, function(i, item) {
        if(i>=1) {
          $(".credit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        }
        $(".credit-row:eq("+i+") input").val(item.to_usd);
        $(".credit-row:eq("+i+") select").val(item.account_id);
        i++;
    });

    $(".debit-row:not(:first)").remove();
    var i = 0;
    $.each(data.debits, function(i, item) {
        if(i>=1) {
          $(".debit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        }
        $(".debit-row:eq("+i+") input").val(item.to_usd);
        $(".debit-row:eq("+i+") select").val(item.account_id);
        i++;
    });
    $('input').unbind("click");
    $('input').one("click",function() {
        //update_journal_entry_form(myid);
    });
  });
}
