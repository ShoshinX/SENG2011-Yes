import { setupLoginPage } from "./js/loginPage";

(function() {
    let token = localStorage.getItem("token");
    let userType = localStorage.getItem("userType");
    switch (userType) {
        case 'vampire':
            //TODO
            break;
        case 'batMobile':
            //TODO
            break;
        case 'hospital':
            //TODO
            break;
        case 'Donor':
            //TODO
            break;
        default:
            setupLoginPage();

    }
});