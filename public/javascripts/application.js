function reply(add_post) {
  add_post = $(add_post);
  add_post.slideUp('fast');
  var form = add_post.next('.new_post_fields');
  form.slideDown('fast');
  form.find('input[type=text]').first().get()[0].focus();
}

function cheer(link) {
  link = $(link);
  var cheer_counter = link.siblings('.cheer-counter').first();
  var cheer_count = parseInt(cheer_counter.html());
  var cheered = cheer_counter.hasClass('cheered');
  if (cheered) {
    // ajax uncheer
    cheer_counter.removeClass('cheered');
    cheer_counter.html(cheer_count - 1);
  } else {
    cheer_counter.addClass('cheered');
    cheer_counter.html(cheer_count + 1);
    // ajax cheer
  }
}

// $(document).ready();

