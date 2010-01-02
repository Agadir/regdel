$('document').ready(function() {

  $("#ledger-table", $("#page-content")).addClass("tablesorter").tablesorter({
    widthFixed: true
  }).tablesorterPager({
    container: $("#table-pager"),
    size: 20,
    positionFixed: false
  });
  

});
