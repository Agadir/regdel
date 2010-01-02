$('document').ready(function() {

  // Relative date must be triggered before tablesorter so that all rows are
  // updated
  var mytime = "";
  var rltime = "";
  $(".reldate", $("#page-content")).each(function () {
      mytime = new Date($(this).text()*1000);
      rltime = relativeDate(mytime);
      $(this).attr("title",mytime);
      $(this).text(rltime);
  });

  // Number of rows in ledger
  var numrows = 16;

  // Setup the tablesorter and pager
  $("#ledger-table", $("#page-content")).addClass("tablesorter").tablesorter({
    widthFixed: true
  }).tablesorterPager({
    container: $("#table-pager"),
    size: numrows,
    positionFixed: false
  });

  // Set the pager number of rows value
  $(".pagesize", $("#table-pager")).val(numrows);

});
