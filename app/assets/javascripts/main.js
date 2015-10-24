// Prevent alert-close to link

$(document).on('ready page:load', function () {
  $("a.alert-close").click(function(event) {
    event.preventDefault();
    $(".alert").hide();;
  });
});
