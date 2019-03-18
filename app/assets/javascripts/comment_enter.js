$('#comment_body').keypress(function (e) {
  if (e.which == 13) {
    $('form#new_comment').submit();
    return false;
  }
});