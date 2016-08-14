/* JavaScript Layout Scripts */

/* Gets the copyright year and the file's last modified date. */
function footerDates() {
    var fileDate = new Date(document.lastModified);
    document.getElementById("footerYear").innerHTML = fileDate.getFullYear();
    var m = fileDate.getMonth() + 1;
    if(m < 10) {
        m = "0" + m.toString();
    }
    var d = fileDate.getDate();
    if(d < 10) {
        d = "0" + d.toString();
    }
    document.getElementById("fileDate").innerHTML = fileDate.getFullYear() + "-" + m + "-" + d;
    return;
}
