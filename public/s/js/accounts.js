/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("#nav-accounts","#navigation").addClass("active");
  //$("table.accounts thead tr").append('<th>Close</th>');
  //$("table.accounts tbody tr").append('<td class="closeacc" style="padding:0"><a href="/account/edit/{@id}" style="display:none;float:right;"><img src="/s/img/pkgs/docunext-webapp-icons/famfamfam/mini/table_delete.gif" alt=""/></a><a href="#" style="display:block;">Close</a></td>');
  $(".editacc","table.accounts").hover(
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .editacc a:first").show();
        $("#"+myid+" .editacc a").addClass("focus");
      },
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .editacc a:first").hide();
        $("#"+myid+" .editacc a").removeClass("focus");
      }
  );
  $(".accbal","table.accounts").hover(
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .accbal a:first").show();
        $("#"+myid+" .accbal a").addClass("focus");
      },
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .accbal a:first").hide();
        $("#"+myid+" .accbal a").removeClass("focus");
      }
  );
  $(".acctype","table.accounts").hover(
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .acctype a:first").show();
        $("#"+myid+" .acctype a").addClass("focus");
      },
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .acctype a:first").hide();
        $("#"+myid+" .acctype a").removeClass("focus");
      }
  );
  $(".closeacc","table.accounts").hover(
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .closeacc a:first").show();
        $("#"+myid+" .closeacc a").addClass("focus");
      },
      function () {
        var myid = $(this).parent().get(0).getAttribute('id');
        $("#"+myid+" .closeacc a:first").hide();
        $("#"+myid+" .closeacc a").removeClass("focus");
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
