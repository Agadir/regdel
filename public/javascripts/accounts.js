$('document').ready(function() {

  $("#nav-accounts","#navigation").addClass("active");
  $("a","#accounts-table td").addClass("lft-text");

  $("#accounts-table", $("#page-content")).tablesorter({
  });

});
