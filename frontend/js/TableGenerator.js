/**
 * 
 * A function to generate table
 * @param : [String] where String represents the table headers 
 */
function generateTable(tableHeaders, id) {
    let tbl = document.createElement("table");
    tbl.style.width = "100%";
    tbl.style.border = "1px solid black";
    tbl.setAttribute("id", id);
    tbl.appendChild(createHeaders(tableHeaders));
    return tbl;
}

function createHeaders(tableHeaders) {
    let header_row = document.createElement("tr");
    tableHeaders.forEach(header => {
        let th = document.createElement("th");
        th.textContent = header;
        header_row.appendChild(th);
    });
    return header_row;

}

export { generateTable };