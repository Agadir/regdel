$('document').ready(function() {
  $("#nav-account").addClass("active");

  // Setup validation
  $("#account-form").validate({
    errorPlacement: function(error, element) { },
    rules: {
      name: "required"
    }
  });

  $('#type_id').jselect({
      replaceAll: false,
      loadType: "GET",
      loadUrl: app_prefix+"/s/xml/raw/account_types_select.xml",
      onComplete: function(){
          var label = $('label[for=type_id]');
          
          $('#type_id').find("option[value!=0]").addClass("realoption");
      //    $('#type_id').prepend($("<option></option>").text(label.html()));
      }
  });

  var myid = jQuery.url.setUrl(fixturl).segment(2);
  if (myid > 0) {
    var hide = "";
    $.getJSON(app_prefix+"/json/account/"+myid, function(data) {
        $.each(data, function(i, item) {
            if ($('#' + i).length) {
                if($('#' + i).attr("type")=="checkbox") {
                    $('#' + i).val([item]);
                } else {
                    $('#' + i).val(item);
                }
            }
            // Set hidden status
            if(i=='hide') {
              hide = item;
            }
        });
        setup_labels();
    });
    // Set account id
    $("#account-form").append('<input type="hidden" name="id" value="' + myid +'" />');
    // Show or hide the account
    if(hide=='null') {
      $("#display-toggle",$("#account-form")).val("Hide Account");
    } else {
      $("#display-toggle",$("#account-form")).val("Show Account");
    }
  } else {
    $("div.form-meta-controls",$("#account-form")).hide();
    setup_labels();
  }




  $(":input[value='Cancel']",$("#account-form")).bind("click", function() {
      history.go(-1);
  });
  $("#account-form ul").css("padding-top","1em");
});

function setup_labels() {
  $(':text, textarea',$("#account-form")).each(function(){
    var label = $('label[for=' + $(this).attr('id') + ']');
    //$(this).parent().wrapInner(document.createElement("div"));
    if (!$(this).val() == '' || $(this).val() == 'undefined') {
      label.hide();
    }
    $(this).before(label);
    label.addClass('overlayed');
    $(this)
      .focus(function(e){
        $('label[for=' + $(e.target).attr('id') + ']').hide();
      })
      .blur(function(e){
        if ($(e.target).val() == '') {
          $('label[for=' + $(e.target).attr('id') + ']').show();
        }
      });
  });

  $('select',$("#account-form")).each(function(){
    var label = $('label[for=' + $(this).attr('id') + ']');
    label.hide();
    $(this).prepend($("<option></option>").attr("value","0").attr("class","hint").html("Select "+label.text()));
    if($(this).val() == 0 || $(this).val() == 'undefined') {
      $(this).addClass("hint");
    }
    $(this)
      .change(function(e){
        if ($(e.target).val() !== '0') {
          $(e.target).removeClass("hint");
          $("option[value='0']",$(e.target)).remove();
        }
      });
  });
}
