$(function() {
  $("#form-title").on("blur", function() {
    const value = $(this).val();
    const directory = value.split("/")
    const title = directory.slice(-1)[0]
    const validation = $(this).next();

    if (value == "" || !value.match(/[^\s\t]/)) {
      validation.text('タイトルを入力してください！');
    } else if (title.length > 50 ) {
      validation.text('タイトルは50文字以内で入力してください！');
      return false;
    } else if (directory.length > 6) {
      validation.text('ディレクトリは5つ以上作成できません！');
    } else {
      validation.text("");
    }

    let result = false;
    $.each(directory, function(index, value) {
      if (value.length > 20) {
        result = true;
        return false;
      }
    });
    if (result) { validation.text('ディレクトリ名は20文字以内です'); }
  });
});
