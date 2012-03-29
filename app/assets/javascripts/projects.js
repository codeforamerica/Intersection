$(document).ready(function () {
  $('.datepicker').datepicker({
    dateFormat : "yy-mm-dd"
  });
  $("a.close").on("click", function(){$("div.alert").fadeOut()});
});

