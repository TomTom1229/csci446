$(function() {
	var i = 1;
	while (i <= 100) {
		$("#rank").append($("<option />").val(i).text(i).html(i));
		i += 1;
	}
});
