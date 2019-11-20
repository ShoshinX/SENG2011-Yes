import { initApp } from "./main.js";

function setupLoginPage() {
    let body_div = document.getElementById("Content");

    let login_div = document.createElement("div");
    login_div.id = "LoginForm";

    let title = document.createElement("h1");
    title.textContent = "VBMS";
    login_div.appendChild(title);
    body_div.appendChild(login_div);

    let loginForm_form = document.createElement("form");

    let loginForm_username = document.createElement("input");
    loginForm_username.type = "text";
    loginForm_username.id = "username";
    loginForm_username.required = "true";
    loginForm_username.placeholder = "username";

    let username_div = document.createElement("div");
    username_div.appendChild(loginForm_username);
    loginForm_form.appendChild(username_div);

    let loginForm_password = document.createElement("input");
    loginForm_password.type = "password";
    loginForm_password.id = "password";
    loginForm_password.required = "true";
    loginForm_password.placeholder = "password";

    let password_div = document.createElement("div");
    password_div.appendChild(loginForm_password);
    loginForm_form.appendChild(password_div);

    let loginForm_submit = document.createElement("input");
    loginForm_submit.type = "submit";
    loginForm_submit.value = "Login";

    let submit_div = document.createElement("div");
    submit_div.appendChild(loginForm_submit);
    loginForm_form.appendChild(submit_div);
    loginForm_form.addEventListener("submit", e => {
        e.preventDefault();
        //TODO implement token for identification of specific user
        // to change type of user, use code below
        // get username and password;
        let username = loginForm_username.value;
        let password = loginForm_form.value;
        switch (username) {
            case "vampire":
                localStorage.setItem("userType", "vampire");
                break;
            case "hospital":
                localStorage.setItem("userType", "hospital");
                break;
        }
        initApp();
    });
    login_div.appendChild(loginForm_form);

};

export { setupLoginPage };