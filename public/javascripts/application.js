$(document).ready(function() {
  var add_post = $('#add_post');
  add_post.click(function() {
    add_post.slideUp('fast');
    var template = add_post.next('.new_post_fields');
    var clone = template.clone();
    clone.insertAfter(template);
    clone.slideDown('fast');
    clone.find('textarea').first().get()[0].focus();
  });
});

