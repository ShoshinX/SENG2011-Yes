import { initApp } from "./js/main.js";

let signOut_li = document.getElementById("signOut");
signOut_li.addEventListener("click", e => {
    let userType = localStorage.removeItem("userType");
    initApp();
})
initApp();