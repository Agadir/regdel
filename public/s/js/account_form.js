/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("#nav-account").addClass("active");

  // Setup validation
  $("#account-form").validate({
    errorPlacement: function(error, element) { },
    rules: {
      name: "required"
    }
  });
  //$.validator.messages.required = "";

  $('#type_id').jselect({
      replaceAll: true,
      loadType: "GET",
      loadUrl: app_prefix+"/s/xml/raw/account_types_select.xml",
  });
  var myid = jQuery.url.segment(2);
  if (myid > 0) {
    $.getJSON(app_prefix+"/json/account/"+myid, function(data) {
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
  }
  $("form").append('<input type="hidden" name="id" value="' + myid +'" />');
});
