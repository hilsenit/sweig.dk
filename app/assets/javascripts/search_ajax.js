$(document).ready(function($) {
	$("#soegeFelt").on("keyup paste", function() {
		$(".find-headline").text("SØG");
		$(".underline").removeClass('underline');
		$(".search-results-load").show();
		$search_text = $(this).val();
		$.ajax({
			url: '/soegefelt/resultat',
			type: 'GET',
			data: {search: $search_text}
		});	
		$(".search-results-load").delay(800).fadeOut(300);
	});
});

