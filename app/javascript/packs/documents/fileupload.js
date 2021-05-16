$("#image").change(() => {
  const imageData = $("#image").prop("files")[0];
  const formData = new FormData();
  formData.append("image", imageData);

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
  });
});
