$(document).ready(function() {
	$(".confirm_horse_from_tel").change(function(){
		var horse_id = $(this).val();
		var race_id = $(this).attr("race");
	  $.ajax({url: "/horseraces/confirm_horse", type: "POST", data: {race_id: race_id, horse_id: horse_id}}).done(function(data){
			location.reload(true);
		});
	});
});