/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {

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
});
