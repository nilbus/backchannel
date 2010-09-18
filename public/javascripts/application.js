function reply(add_post) {
  add_post.slideUp('fast');
  var form = add_post.next('.new_post_fields');
  form.slideDown('fast');
  form.find('input[type=text]').first().get()[0].focus();
}

// $(document).ready();

