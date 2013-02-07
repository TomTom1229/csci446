$(function() {
	$(".selectpicker").selectpicker();
	$("tr").hover(function() {
		$(this).addClass("warning");
	})
	$("tr").mouseout(function() {
		$(this).removeClass("warning");
	})
}); 