/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("tr","#journal-table-entries").addClass("entry-row");
  $("#nav-journal","#navigation").addClass("active");

  $("thead tr", "#journal-table").append('<th class="text-right">Edit</th>');
  $(".entry-row td:first-child", "#journal-table-entries").addClass("reldate");
  $(".entry-row", "#journal-table-entries").each(
    function () {
      var myid = $(this).get(0).getAttribute('id');
      $(this).append('<td class="notoggle text-right"><a href="/entry/edit/'+myid+'">edit</a></td>');
    }
  );
  $(".entry-row td:not(.notoggle)","#journal-table-entries").toggle(
    function () {
      $(".entry_detail").remove();
      var myid = $(this).parent().get(0).getAttribute('id');
      get_journal_detail(myid);
    },
    function () {
      $(".entry_detail","#journal-table-entries").remove();
    }
  );
  $("#journal-table", "#page-content").tablesorter({
  });
});

function get_journal_detail(myid) {
  $(".entry_detail").remove();
  $.getJSON("/json/entry/"+myid, function(data) {
    $.each(data.credits, function(i, item) {
        var myamounts = '<tr class="entry_detail credit">';
        myamounts += '<td>'+item.account_id+'</td>';
        myamounts += '<td>'+item.memorandum+'</td>';
        myamounts += '<td/>';
        myamounts += '<td>'+item.to_usd+'</td>';
        myamounts += '<td></td>';
        myamounts += '</tr>';
        $("#"+myid).after(myamounts);
    });
    $.each(data.debits, function(i, item) {
        var myamounts = '<tr class="entry_detail debit">';
        myamounts += '<td>'+item.account_id+'</td>';
        myamounts += '<td>'+item.memorandum+'</td>';
        myamounts += '<td>'+item.to_usd+'</td>';
        myamounts += '<td></td>';
        myamounts += '<td></td>';
        myamounts += '</tr>';
        $("#"+myid).after(myamounts);
    });
  });
}
