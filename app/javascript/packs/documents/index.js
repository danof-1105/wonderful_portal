$(function () {
  $('.js-directory__item__link').each(function () {
    $(this).on('click', function () {
      $("+.directory_children",this).slideToggle();
      return false;
    });
  });
});
