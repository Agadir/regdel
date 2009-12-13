/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("#nav-accounts","#navigation").addClass("active");
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
