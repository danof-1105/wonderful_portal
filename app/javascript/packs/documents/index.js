$(function () {
  $('.js-directory__item__link').each(function () {
    $(this).on('click', function () {
      $("+.area",this).slideToggle();
      // return false;
    });
  });
});
