$(document).ready(function () {
    $.get("https://us-central1-cloudresumechallenge-406720.cloudfunctions.net/visitorCounterFunction", function (data, status) {
        document.getElementById("visitorCount").innerHTML = "VisitorCounter: " + data['visitorNumber'];
    }).fail(function(){
                console.log("Error in counter!");
            });
});