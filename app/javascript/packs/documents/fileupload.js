$(function() {
  $('#markdown_editor_textarea').on('drop', function(e) {
    e.preventDefault();
    f = e.originalEvent.dataTransfer.files[0];
    const imageData = $('#image').prop('files', f);
    const formData = new FormData();
    formData.append("image", f);

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
});
