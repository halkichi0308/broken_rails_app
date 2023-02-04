window.addEventListener("turbolinks:load", () => {
    "use strict";
    function hasLocationSearch_page() {
        return /page(?=\=)/.test(location.search);
    }

    let collapsible_body = document.getElementsByClassName("collapsible-body");

    if (hasLocationSearch_page() === true) {
        collapsible_body[0].style.display = "block";
    }
});

function currentURLCopy() {
    navigator.clipboard.writeText(shareURL.innerText);
    let copyIcon = document.querySelector(".copy");
    copyIcon.className = "copy";
    copyIcon.innerText = "[copied!]";
}
