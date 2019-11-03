import { generateTable } from "./TableGenerator.js";

function setupVampirePage() {
    // notifications left side with a drop down action to expand on the contents of notifications
    // insertion of blood top right
    // view of blood bottom right
    // in one page
    // Vampire user doesn't have to deal with logs, only with notifications from system
    // server administrator does the logs 
    let content_div = document.getElementById("Content");
    let vampireContent_div = document.createElement("div");
    vampireContent_div.style.display = "grid";
    vampireContent_div.style.gridTemplateColumns = "25% 75%";
    vampireContent_div.style.gridTemplateRows = "25% 75%";
    vampireContent_div.style.height = "100%";
    vampireContent_div.style.width = "100%";
    content_div.appendChild(vampireContent_div);
    let notifCol_div = document.createElement("div");
    notifCol_div.style.gridColumnStart = 1;
    notifCol_div.style.gridColumnEnd = 1;
    notifCol_div.style.gridRowStart = 1;
    notifCol_div.style.gridRowEnd = 2;
    vampireContent_div.appendChild(notifCol_div);
    let bloodInsert_div = document.createElement("div");
    bloodInsert_div.style.gridColumnStart = 2;
    bloodInsert_div.style.gridColumnEnd = 2;
    bloodInsert_div.style.gridRowStart = 1;
    bloodInsert_div.style.gridRowStart = 1;
    vampireContent_div.appendChild(bloodInsert_div);
    let bloodTable_div = document.createElement("div");
    bloodTable_div.style.gridColumnStart = 2;
    bloodTable_div.style.gridColumnEnd = 2;
    bloodTable_div.style.gridRowStart = 2;
    bloodTable_div.style.gridRowStart = 2;
    vampireContent_div.appendChild(bloodTable_div);
    notifCol_div.textContent = "notification";
    bloodInsert_div.textContent = "bloodInsert";
    bloodTable_div.textContent = "BloodTable";
    notifCol_div.appendChild(generateTable(["Date Notified", "Messages"], "notification"));
    bloodTable_div.appendChild(generateTable(["Blood Type", "Origin", "Prod. Date", "Expiry Date", "Freshness"]), "bloodTable");
    bloodInsert_div.appendChild(bloodInsert_form());
    // TODO setup insertion of values here
}


function bloodInsert_form() {
    let BIForm = document.createElement("form");
    let input_div = document.createElement("div");
    let BType_input = document.createElement("input");
    BType_input.id = "blood type";
    BType_input.placeholder = "Blood Type";
    let Origin_input = document.createElement("input");
    Origin_input.id = "origin";
    Origin_input.placeholder = "Origin";
    let PDate_input = document.createElement("input");
    PDate_input.id = "prod date";
    PDate_input.placeholder = "Prod. Date";
    let EDate_input = document.createElement("input");
    EDate_input.id = "exp date";
    EDate_input.placeholder = "Exp. Date";
    let Freshness_input = document.createElement("input");
    Freshness_input.id = "freshness";
    Freshness_input.placeholder = "freshness";
    let IsOkay_input = document.createElement("input");
    Freshness_input.id = "isOkay";
    Freshness_input.placeholder = "isOkay";
    input_div.appendChild(BType_input);
    input_div.appendChild(Origin_input);
    input_div.appendChild(PDate_input);
    input_div.appendChild(EDate_input);
    input_div.appendChild(Freshness_input);
    BIForm.appendChild(input_div);
    let submit_div = document.createElement("div");
    let submit_input = document.createElement("input");
    submit_input.type = "submit";
    submit_input.value = "insert";
    input_div.addEventListener("submit", e => {
        e.preventDefault();
        // TODO submit action add here
    })
    submit_div.appendChild(submit_input);
    BIForm.appendChild(submit_div);
    return BIForm;
}


export { setupVampirePage };