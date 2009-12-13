/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("#nav-accounts","#navigation").addClass("active");
  //$("table.accounts thead tr").append('<th>Close</th>');
  //$("table.accounts tbody tr").append('<td class="closeacc" style="padding:0"><a href="/account/edit/{@id}" style="display:none;float:right;"><img src="/s/img/pkgs/docunext-webapp-icons/famfamfam/mini/table_delete.gif" alt=""/></a><a href="#" style="display:block;">Close</a></td>');


  $(".acctrow td","table.accounts").hover(
      function () {
        $("a:first",$(this)).show();
        $("a",$(this)).addClass("focus");
      },
      function () {
        $("a:first",$(this)).hide();
        $("a",$(this)).removeClass("focus");
      }
  );
  /*
  $("table.accounts tbody td:last").click(function () {
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
  */

});
