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
    let BTRequest_input = document.createElement("select");
    bloodtypes(BTRequest_input);
    BTRequest_input.placeholder = "recipient blood type";
    let submit = document.createElement("input");
    submit.type = "submit";
    submit.value = "GET";
    request_form.addEventListener("submit", e => {
        e.preventDefault();
        // TODO add functionality into the request
        let bt = BTRequest_input.value;
        fetch("http://localhost:9000/api/requestBR/" + bt).then(resp => resp.json()).then(g => {
            if (g != null) { alert("Congrats your requested blood is on the way:\n" + JSON.stringify(g)) } else { alert("Sorry it looks like we don't have stock that matches your bloodtype") };
        });
    })
    request_form.appendChild(BTRequest_input);
    request_form.appendChild(submit);
    hospitalPage_div.appendChild(request_form);
    login_div.appendChild(hospitalPage_div);
}

function bloodtypes(bloodtype_sel) {
    let BloodType = document.createElement("option");
    BloodType.value = "BloodType";
    BloodType.innerText = "BloodType";
    BloodType.setAttribute("disabled", "");
    BloodType.setAttribute("selected", "");
    BloodType.setAttribute("value", "");
    let A = document.createElement("option");
    A.value = "A";
    A.innerText = "A";
    let B = document.createElement("option");
    B.value = "B";
    B.innerText = "B";
    let AB = document.createElement("option");
    AB.value = "AB";
    AB.innerText = "AB";
    let O = document.createElement("option");
    O.value = "O";
    O.innerText = "O";
    bloodtype_sel.appendChild(BloodType);
    bloodtype_sel.appendChild(A);
    bloodtype_sel.appendChild(B);
    bloodtype_sel.appendChild(AB);
    bloodtype_sel.appendChild(O);
}

export { setupHospitalPage };