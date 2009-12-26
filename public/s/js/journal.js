/* Regdel Javascript */
// Read a page's GET URL variables and return them as an associative array.

$('document').ready(function() {
  $("#nav-journal","#navigation").addClass("active");

  $("thead tr", $("#journal-table")).append('<th class="text-right">Edit</th>');

  $("tr", $("#journal-table-entries")).addClass("entry-row")
  .each(function () {
      var myid = $(this).get(0).getAttribute('id');
      $(this).append('<td class="text-right"><a href="'+app_prefix+'/entry/edit/'+myid+'">edit</a></td>');
  })
  .find("td:first-child").addClass("reldate")
  .parent().find("td:not(:last)").toggle(
    function () {
      var myid = $(this).parent().get(0).getAttribute('id');
      get_journal_detail(myid);
    },
    function () {
      $(".entry_detail",$("#journal-table-entries")).remove();
    }
  );

  $("#journal-table", $("#page-content")).tablesorter({
  });

});

function get_journal_detail(myid,journal_table_entries) {
  $(".entry_detail",journal_table_entries).remove();
  $.getJSON(app_prefix+"/json/entry/"+myid, function(data) {
    $.each(data.credits, function(i, item) {
        var myamounts = '<tr class="entry_detail credit">';
        myamounts += '<td>'+item.account_id+'</td>';
        myamounts += '<td>'+item.memorandum+'</td>';
        myamounts += '<td/>';
        myamounts += '<td>'+item.to_usd+'</td>';
        myamounts += '<td></td>';
        myamounts += '</tr>';
        $("#"+myid,journal_table_entries).after(myamounts);
    });
    $.each(data.debits, function(i, item) {
        var myamounts = '<tr class="entry_detail debit">';
        myamounts += '<td>'+item.account_id+'</td>';
        myamounts += '<td>'+item.memorandum+'</td>';
        myamounts += '<td>'+item.to_usd+'</td>';
        myamounts += '<td></td>';
        myamounts += '<td></td>';
        myamounts += '</tr>';
        $("#"+myid,journal_table_entries).after(myamounts);
    });
  });
}
