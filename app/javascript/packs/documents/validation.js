$(function() {
  $("#form-title").on("blur", function() {
    const value = $(this).val();
    const directory = value.split("/")
    const title = directory.slice(-1)[0]
    const validation_msg = []
    const validation = $("#title-error-message");

    // HACK: switch文に変更予定
    if (value == "" || !value.match(/[^\s\t]/)) {
      validation_msg.push('タイトルを入力してください！');
    } else if (directory.length > 6) {
      validation_msg.push('ディレクトリは5つ以上作成できません！');
    } else if (title.length > 50 ) {
      validation_msg.push('タイトルは50文字以内で入力してください！');
    }

    $.each(directory, (index, value) => { if(value.length > 20) { validation_msg.push('ディレクトリ名は20文字以内です') } });

    if (validation_msg.length > 0) {
      validation.text(validation_msg);
    } else {
      validation.text("");
    }
  });
});
