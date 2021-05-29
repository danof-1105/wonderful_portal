$(function() {
  $(".form-title").on("blur", function() {
    let value = $(this).val();
    let directory = value.split("/")
    let title = directory.slice(-1)[0]

    if (value == "" || !value.match(/[^\s\t]/)) {
      $(this).next().text('タイトルを入力してください！');
    } else if (title.length > 50 ) {
      $(this).next().text('タイトルは50文字以内で入力してください！');
      return false;
    } else if (directory.length > 6) {
      $(this).next().text('ディレクトリは5つ以上作成できません！');
    } else {
      $(this).next().text("");
    }

    let result = false;
    $.each(directory, function(index, value) {
      if (value.length > 20) {
        result = true;
        return false;
      }
    });
    if (result) { $(this).next().text('ディレクトリ名は20文字以内です'); }
  });
});
