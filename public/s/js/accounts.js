/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("#nav-accounts","#navigation").addClass("active");
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
  $("table.accounts thead tr").append('<th class="text-right">Close</th>');
  $("table.accounts tbody tr").append('<td class="text-right"><a href="#">Close</a></td>');
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

});
