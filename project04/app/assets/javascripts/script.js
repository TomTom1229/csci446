$(function(){
    setInterval(updateClock, 1000);
    $("em.current").addClass("disabled");
});

function updateClock() {
    var now = new Date();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
    var mer = "AM";
    if(hour > 12) {
        hour -= 12;
        mer = "PM";
    }

    $("#clock").html(sprintf("%'02u:%'02u:%'02u %s", hour, minute, second, mer));
}