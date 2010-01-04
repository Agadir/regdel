$('document').ready(function() {

  $("#nav-home","#navigation").addClass("active");

  $("ul", $("#page-content")).addClass("list");

  $("pre", $("#page-content")).css("padding","10px")
  .css("line-height","1.4em")
  .css("font-size","116%");

  sh_highlightDocument(app_prefix+'s/js/pkgs/shjs/shjs-0.6/lang/', '.js');
});
