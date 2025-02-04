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
    notifCol_div.style.gridRowEnd = 1;
    notifCol_div.style.overflow = "auto";
    vampireContent_div.appendChild(notifCol_div);
    let log_div = document.createElement("div");
    log_div.style.gridColumnStart = 1;
    log_div.style.gridColumnEnd = 1;
    log_div.style.gridRowStart = 2;
    log_div.style.gridRowEnd = 2;
    log_div.style.overflow = "auto";
    vampireContent_div.appendChild(log_div);
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
    bloodInsert_div.textContent = "bloodInsert";
    bloodTable_div.textContent = "BloodTable";
    notifCol_div.appendChild(generateTable(["Notifications"], "notification"));
    log_div.appendChild(generateTable(["Log", "Message"], "log"));
    bloodTable_div.appendChild(generateTable(["Blood Type", "Origin", "Prod. Date", "Expiry Date", "Freshness"], "bloodTable"));
    bloodInsert_div.appendChild(bloodInsert_form());
    bloodInsert_div.appendChild(generateTable(["A", "B", "AB", "O"], "bloodLevelTable"));
    // TODO setup insertion of values here
    getBloodInfo();
    getNotif();
    getLog();
    getBloodLevels();
}
async function getBloodInfo() {
    let bloodTable = document.getElementById("bloodTable");
    while (bloodTable.childElementCount != 1) {
        bloodTable.removeChild(bloodTable.lastChild);
    }
    let jsonResp = await fetch("http://localhost:9000/api/viewBR").then((resp) => resp.json());
    const bloodRecords = jsonResp.BloodRecords;
    for (let index = 0; index < bloodRecords.length; index++) {
        const bloodrecord = bloodRecords[index];
        let newRow_tr = document.createElement("tr");
        bloodTable.appendChild(newRow_tr);
        let BT_td = document.createElement("td");
        BT_td.innerText = bloodrecord.BloodType;
        newRow_tr.appendChild(BT_td);
        let Ori_td = document.createElement("td");
        Ori_td.innerText = bloodrecord.location;
        newRow_tr.appendChild(Ori_td);
        let Prod_td = document.createElement("td");
        Prod_td.innerText = bloodrecord.donationDate;
        newRow_tr.appendChild(Prod_td);
        let Exp_td = document.createElement("td");
        Exp_td.innerText = bloodrecord.expiryDate;
        newRow_tr.appendChild(Exp_td);
        let Fr_td = document.createElement("td");
        Fr_td.innerText = bloodrecord.isOkay;
        newRow_tr.appendChild(Fr_td);
    }

}
async function getNotif() {
    let notifTable = document.getElementById("notification");
    while (notifTable.childElementCount != 1) {
        notifTable.removeChild(notifTable.lastChild);
    }
    let jsonResp = await fetch("http://localhost:9000/api/viewNotifs").then((resp) => resp.json());
    const notifs = jsonResp.Notifications.reverse();
    for (let index = 0; index < notifs.length; index++) {
        const notif = notifs[index];
        let newRow_tr = document.createElement("tr");
        notifTable.appendChild(newRow_tr);
        let Msg_td = document.createElement("td");
        Msg_td.innerText = notif;
        newRow_tr.appendChild(Msg_td);
    }
}
async function getLog() {
    let logTable = document.getElementById("log");
    while (logTable.childElementCount != 1) {
        logTable.removeChild(logTable.lastChild);
    }
    let jsonResp = await fetch("http://localhost:9000/api/viewLog").then((resp) => resp.json());
    const logs = jsonResp.Log.reverse();
    for (let index = 0; index < logs.length; index++) {
        const log = logs[index];
        let newRow_tr = document.createElement("tr");
        logTable.appendChild(newRow_tr);
        let act_td = document.createElement("td");
        act_td.innerText = log.Action;
        newRow_tr.appendChild(act_td);
        let Msg_td = document.createElement("td");
        Msg_td.innerText = log.Message;
        newRow_tr.appendChild(Msg_td);
    }

}
async function getBloodLevels() {
    let bloodLevelTable = document.getElementById("bloodLevelTable");
    while (bloodLevelTable.childElementCount != 1) {
        bloodLevelTable.removeChild(bloodLevelTable.lastChild);
    }
    let jsonResp = await fetch("http://localhost:9000/api/viewBRLevels").then((resp) => resp.json());
    const logs = jsonResp.BloodRecordsLevels;
    console.log(logs);
    let newRow_tr = document.createElement("tr");
    bloodLevelTable.appendChild(newRow_tr);
    for (let index = 0; index < logs.length; index++) {
        const log = logs[index];
        let level_td = document.createElement("td");
        level_td.innerText = log;
        newRow_tr.appendChild(level_td);
    }

}

function bloodInsert_form() {
    let BIForm = document.createElement("form");
    let input_div = document.createElement("div");
    let BType_input = document.createElement("select");
    BType_input.id = "blood type";
    BType_input.placeholder = "Blood Type";
    bloodtypes(BType_input);
    let Origin_input = document.createElement("input");
    Origin_input.id = "origin";
    Origin_input.placeholder = "Origin";
    let PDate_input = document.createElement("input");
    PDate_input.id = "prod date";
    PDate_input.type = "date";
    PDate_input.placeholder = "Prod. Date";
    let EDate_input = document.createElement("input");
    EDate_input.id = "exp date";
    EDate_input.type = "date";
    EDate_input.placeholder = "Exp. Date";
    let Freshness_input = document.createElement("select");
    Freshness_input.id = "freshness";
    Freshness_input.placeholder = "freshness";
    trueFalse(Freshness_input);
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
    BIForm.addEventListener("submit", e => {
        e.preventDefault();
        // TODO submit action add here
        let br = {
            BloodType: BType_input.value,
            Location: Origin_input.value,
            ProdDate: PDate_input.value,
            ExpDate: EDate_input.value,
            IsOkay: Freshness_input.value
        }
        fetch("http://localhost:9000/api/addBR", {
            method: "POST",
            body: JSON.stringify(br),
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(() => {
            getBloodInfo();
            getBloodLevels();
            getLog();
            getNotif()
        });
    })
    submit_div.appendChild(submit_input);
    BIForm.appendChild(submit_div);
    return BIForm;
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

function trueFalse(select) {
    let isFresh = document.createElement("option");
    isFresh.value = "isFresh";
    isFresh.innerText = "isFresh";
    isFresh.setAttribute("disabled", "");
    isFresh.setAttribute("selected", "");
    isFresh.setAttribute("value", "");
    let True = document.createElement("option");
    True.value = "True";
    True.innerText = "True";
    let False = document.createElement("option");
    False.value = "False";
    False.innerText = "False";
    select.appendChild(isFresh);
    select.appendChild(True);
    select.appendChild(False);
}

export { setupVampirePage };