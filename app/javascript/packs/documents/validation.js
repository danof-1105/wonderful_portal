$(function() {
  $("#form-title").on("blur", function() {
    const value = $(this).val();
    const directory = value.split("/")
    const title = directory.slice(-1)[0]
    const validation = $("#title-error-message");

    // HACK: switch文に変更予定
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

    $.each(directory, (index, value) => { if(value.length > 20) { validation.text('ディレクトリ名は20文字以内です') } });
  });
});
