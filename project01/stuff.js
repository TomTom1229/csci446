$(function() {
	$("#submit").click(checkFeelToday);
});  

function checkFeelToday() {
	if($("#feeling").val() == "")
		alert("Surely you feel something!");
}
