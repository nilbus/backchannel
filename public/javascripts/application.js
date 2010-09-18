function reply(add_post) {
  add_post = $(add_post);
  add_post.slideUp('fast');
  var form = add_post.next('.new_post_fields');
  form.slideDown('fast');
  form.find('input[type=text]').first().get()[0].focus();
}

function cheer(link) {
  link = $(link);
  var cheer_count = link.siblings('.cheer-count').first();
  var cheered = cheer_count.hasClass('cheered');
  if (cheered) {
    cheer_count.removeClass('cheered');
    // ajax uncheer
  } else {
    cheer_count.addClass('cheered');
    // ajax cheer
  }
}

// $(document).ready();

