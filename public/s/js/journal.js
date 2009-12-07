/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {

  $(".entry_row").each(
    function () {
      var myid = $(this).get(0).getAttribute('id');
      $(this).append('<td class="notoggle"><a href="/entry/edit/'+myid+'">edit</a></td>');
    }
  );
  $(".entry_row td:not(.notoggle)").toggle(
      function () {
          $(".entry_detail").remove();
          var myid = $(this).parent().get(0).getAttribute('id');
          $.getJSON("/json/entry/"+myid, function(data) {
              $.each(data.credits, function(i, item) {
                  var myamounts = '<tr class="entry_detail credit">';
                  myamounts += '<td>'+item.account_id+'</td>';
                  myamounts += '<td>'+item.memorandum+'</td>';
                  myamounts += '<td/>';
                  myamounts += '<td>'+item.to_usd+'</td>';
                  myamounts += '</tr>';
                  $("#"+myid).after(myamounts);
              });
              $.each(data.debits, function(i, item) {
                  var myamounts = '<tr class="entry_detail debit">';
                  myamounts += '<td>'+item.account_id+'</td>';
                  myamounts += '<td>'+item.memorandum+'</td>';
                  myamounts += '<td>'+item.to_usd+'</td>';
                  myamounts += '<td/>';
                  myamounts += '</tr>';
                  $("#"+myid).after(myamounts);
              });
          });
      },
      function () {
          $(".entry_detail").remove();
      }
  );
  
});
