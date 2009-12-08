/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {

  $("table.accounts thead tr").append('<th>Close</th>');
  $("table.accounts tbody tr").append('<td>Close</td>');
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
