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
