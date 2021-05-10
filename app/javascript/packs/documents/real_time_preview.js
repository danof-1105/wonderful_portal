$(function () {
  $("#markdown_editor_textarea").keyup(function () {
    const html = marked($(this).val());
    $("#markdown_preview").html(html);
  });
});
