function setupVampirePage() {
    // notifications left side with a drop down action to expand on the contents of notifications
    // insertion of blood top right
    // view of blood bottom right
    // in one page
    // log of system in another tab
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
}

export { setupVampirePage };