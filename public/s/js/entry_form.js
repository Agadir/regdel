$('document').ready(function() {

  $("#nav-entry").addClass("active");

  // Date picker
  Date.firstDayOfWeek = 0;
  Date.format = 'yyyy-mm-dd';
  $("#entry_datetime").datePicker({startDate:'1996-01-01'});


  // Setup drop-down lists with accounts to choose from
  $('.account_id:first','form').jselect({
    replaceAll: true,
    loadType: "GET",
    loadUrl: app_prefix+"/raw/account/select",
    onComplete: function() {
        $('.account_id:first option','form').clone().appendTo('.account_id:not(:first)','form');
    }
  });

  // Setup validation
  $("#journal-entry-form").validate({
    rules: {
      memorandum: "required"
    }
  });

  // Or make text fields with autocomplete
  // var accounts = ["Taxes", "Bank Account"];
  // $(".account_name").focus().autocomplete(accounts);

  $("#another-credit img",$("#journal-entry-amounts")).attr("src", app_prefix+"/s/img/pkgs/docunext-webapp-icons/tango/list-add.png");
  $("#another-debit img",$("#journal-entry-amounts")).attr("src", app_prefix+"/s/img/pkgs/docunext-webapp-icons/tango/list-add.png");
  $(".remove-debit img",$("#journal-entry-amounts")).attr("src", app_prefix+"/s/img/pkgs/docunext-webapp-icons/tango/list-remove.png");
  $(".remove-credit img",$("#journal-entry-amounts")).attr("src", app_prefix+"/s/img/pkgs/docunext-webapp-icons/tango/list-remove.png");

  $(".rd-amt",$("#journal-entry-amounts")).attr("autocomplete","off");

  if(jQuery.url.setUrl(fixturl).segment(2) == 'new') {
    var amount_total = 0;
    $("#another-credit").live("click",function() {
        $("#another-debit").css("display","none");
        $(".credit-row:first").clone().appendTo("#journal-entry-amounts tbody");
        $(".remove-credit:last").css("display","inline");
        $(".debit-row input").attr("readonly","readonly");
        $("#journal-entry-amounts","form").bind("click keyup keypress mouseenter mouseleave",function() {
            amount_total = $(".credit-row input").sum();
            $(".debit-row input").val(amount_total);
        });
    });

    $(".remove-credit").live("click",function() {
        $(this).parent().parent().remove();
        if($(".remove-credit").length == 1) {
          $("#another-debit").css("display","inline");
          $(".debit-row input").removeAttr("readonly");
        }
    });
  
    $("#another-debit").live("click",function() {
        $("#another-credit").css("display","none");
        $(".debit-row:first").clone().prependTo("#journal-entry-amounts tbody");
        $(".remove-debit:not(:first)").css("display","inline");
        $(".credit-row input").attr("readonly","readonly");
        $("#journal-entry-amounts","form").bind("click keyup keypress mouseenter mouseleave",function() {
            amount_total = $(".debit-row input").sum();
            $(".credit-row input").val(amount_total);
        });
    });

    $(".remove-debit").live("click",function() {
        $(this).parent().parent().remove();
        if($(".remove-debit").length == 1) {
          $("#another-credit").css("display","inline");
          $(".credit-row input").removeAttr("readonly");
        }
    });
  }

  if(jQuery.url.setUrl(fixturl).segment(2) == 'edit') {
    $(".amount-controls").hide();
    var myid = jQuery.url.setUrl(fixturl).segment(2);
    update_journal_entry_form(myid);
  }
  // Cancel button goes back
  $(":input[value='Cancel']",$("#account-form")).bind("click", function() {
      history.go(-1);
  });
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
