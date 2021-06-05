$('.accordion-side').click(function () {
  $(this).next().animate({ width: 'toggle' }, 'normal');
});
