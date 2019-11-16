function setupHospitalPage() {
    let content_div = document.getElementById("Content");
    let login_div = document.createElement("div");
    login_div.id = "LoginForm";
    let title = document.createElement("h1");
    title.textContent = "VBMS";
    login_div.appendChild(title);
    content_div.appendChild(login_div);

    let hospitalPage_div = document.createElement("div");
    let request_form = document.createElement("form");
    let BTRequest_input = document.createElement("input");
    BTRequest_input.placeholder = "recipient blood type";
    let submit = document.createElement("input");
    submit.type = "submit";
    submit.value = "GET";
    request_form.addEventListener("submit", e => {
        e.preventDefault();
        // TODO add functionality into the request
    })
    request_form.appendChild(BTRequest_input);
    request_form.appendChild(submit);
    hospitalPage_div.appendChild(request_form);
    login_div.appendChild(hospitalPage_div);
}

export { setupHospitalPage };