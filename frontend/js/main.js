import { setupLoginPage } from "./loginPage.js";
import { setupVampirePage } from "./VampirePage.js";
import { setupHospitalPage } from "./HospitalPage.js";

function initApp() {
    let token = localStorage.getItem("token");
    let userType = localStorage.getItem("userType");
    let Content_div = document.getElementById("Content");
    while (Content_div.firstChild)
        Content_div.removeChild(Content_div.firstChild);
    switch (userType) {
        case 'vampire':
            //TODO
            setupVampirePage();
            break;
        case 'batMobile':
            //TODO
            break;
        case 'hospital':
            //TODO
            setupHospitalPage();
            break;
        case 'donor':
            //TODO
            break;
        default:
            setupLoginPage();
            break;
    }
}

export { initApp };