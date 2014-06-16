$(document).ready(function() {
	$("#menu_horse_id").change(function(){
		$.ajax({
	     url : 'menu/raceList',
	     method: "GET",
	     data: "horse_id=" + $(this).val(),
	     success: function(response) {
	     		$('#racemenu').html(resonse);
	     }
		})
	});


	$('.suggestion').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_id = $(this).attr("race");
	  $.ajax({url: "/notifications", type: "POST", data: {notification: { send_id: race_id, recv_id: horse_id, action: "Suggest"}}}).done(function(data){
					location.reload(true);
		});
	})

	$('.winner').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_id = $(this).attr("race");
	  $.ajax({url: "add_winner", type: "POST", data: {race_id: race_id, horse_id: horse_id}}).done(function(data){
					location.reload(true);
		});
	})

	$('.scratch').on('click', function (e) {
		var horse_id = $(this).attr("horse");
		var race_id = $(this).attr("race");
	  $.ajax({url: "scratch_horse", type: "POST", data: { race_id: race_id, horse_id: horse_id}}).done(function(data){
					location.reload(true);
		});
	})

})
