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
  var post_id = link.closest('.post').attr('id');
  if (cheered) {
    cheer_counter.removeClass('cheered');
    cheer_counter.html(cheer_count - 1);
    $.ajax({
      url: '/posts/' + post_id + '/cheers/destroy',
      type: 'POST',
      data: {'_method': 'delete'},
    });
  } else {
    cheer_counter.addClass('cheered');
    cheer_counter.html(cheer_count + 1);
    $.ajax({
      url: '/posts/' + post_id + '/cheers',
      type: 'POST',
    });
  }
}

$(document).ready(function() {
  var focus_field = $('.autofocus').get()[0];
  if (focus_field)
    focus_field.focus();
});
