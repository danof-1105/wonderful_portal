// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
import "../src/application.scss";
import marked from "marked";
import "@fortawesome/fontawesome-free/js/all";
import hljs from "highlight.js";

marked.setOptions({
  highlight: function (code) {
    return hljs.highlightAuto(code).value;
  },
});

window.marked = marked;

Rails.start();
Turbolinks.start();
ActiveStorage.start();
window.jQuery = $;
window.$ = $;
