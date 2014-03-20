$(document).ready(function() {



});



// Show and hide pens btn on adminlead page
function showHidePensBtn() {
	$('.js-customerPart .control-group').each(function() {
		$(this).hover(function() {
			$(this).find(".js-btnEditSave").removeClass("hidden");
		}, function() {
			$(this).find(".js-btnEditSave").addClass("hidden");
		});
	});
}