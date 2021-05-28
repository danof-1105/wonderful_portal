$(function() {
  $(".form-title").on("blur", function() {
    let error;
    let value = $(this).val();

    if (value == "" || !value.match(/[^\s\t]/)) {
      error = true;
    }

    if (error) {
      $(this).next().text('タイトルを入力してください！');
    } else {
      $(this).next().text("");
    }
  });
});
