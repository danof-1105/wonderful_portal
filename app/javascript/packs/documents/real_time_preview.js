$(function () {
  $("#markdown_editor_textarea").keyup(function () {
    const html = marked($(this).val());
    $("#markdown_preview").html(html);
  });
  const html = marked($("#markdown_editor_textarea").val());
  $("#markdown_preview").html(html);
});
