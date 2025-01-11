// ==UserScript==
// @name         codemirror-handle-vim-esc.user.js
// @version      0.1
// @description  Support Esc key in CodeMirror Vim Mode by preventing propagation  Vivaldi blur event.
// @match        http://*/*
// @match        https://*/*
// ==/UserScript==

(function () {
  function addEscListener(evt) {
    window.removeEventListener('load', addEscListener);
    const cm = document.querySelector('.CodeMirror');
    if (cm) {
      const textarea = cm.querySelector('textarea');
      textarea.addEventListener('keydown', evt => {
        if (evt.key === 'Escape') evt.stopPropagation();
      });
    }
  }
  window.addEventListener('load', addEscListener);
}());

