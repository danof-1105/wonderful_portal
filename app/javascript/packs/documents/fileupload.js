$(function() {
  $('#markdown_editor_textarea').on('drop', function(e) {
    $('#markdown_editor_textarea').css('border', '1px solid #d6dde4');
    e.preventDefault();
    f = e.originalEvent.dataTransfer.files[0];
    const imageData = $('#image').prop('files', f);
    const formData = new FormData();
    formData.append('image', f);

    $.ajax({
      url: "/document_images",
      type: "POST",
      data: formData,
      processData: false,
      contentType: false,
    }).done((data) => {
      const url = data.url;
      const filename = data.filename;
      const textArea = document.getElementById("markdown_editor_textarea");
      const fileLink = `![${filename}](${url})`;
      textArea.value = `${textArea.value}\n${fileLink}`;
      const html = marked($(this).val());
      $("#markdown_preview").html(html);
    });
  });
     // ドラッグしている要素がドロップ領域に入ったとき・領域にある間
  $('#markdown_editor_textarea').on('dragenter dragover', function (e) {
    e.stopPropagation();
    e.preventDefault();
    $('#markdown_editor_textarea').css('border', '1px solid #333');
  });

    // ドラッグしている要素がドロップ領域から外れたとき
  $('#markdown_editor_textarea').on('dragleave', function (e) {
    e.stopPropagation();
    e.preventDefault();
    $('#markdown_editor_textarea').css('border', '1px solid #d6dde4');
  });
    // markdown_editor_textarea以外でファイルがドロップされた場合、ファイルが開いてしまうのを防ぐ
  window.ondrop = function(e){
    e.preventDefault();　//動作する
    };

  window.ondragleave = function(e){
    e.stopPropagation();
    e.preventDefault();
  };

  window.ondragover = function(e){
    e.preventDefault();　//動作する
    };
});
